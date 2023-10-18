#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
using namespace llvm;

namespace
{
  struct MyPass : public FunctionPass
  {
    static char ID;
    MyPass() : FunctionPass(ID) {}

    bool isFuncLogger(StringRef name)
    {
      return name == "getelemptrLogger" || name == "allocOptLogger" || name == "castLogger" || name == "storeLogger" || name == "loadLogger" || name == "logAll" || name == "binOptLogger" || name == "callLogger" ||
             name == "funcStartLogger" || name == "funcEndLogger" || name == "unOptLogger" ||
             name == "cmpLogger" || name == "condBranchLogger" || name == "uncondBranchLogger";
    }

    virtual bool runOnFunction(Function &F)
    {
      if (isFuncLogger(F.getName()))
      {
        return false;
      }
      // Prepare builder for IR modification
      LLVMContext &Ctx = F.getContext();
      IRBuilder<> builder(Ctx);
      Type *retType = Type::getVoidTy(Ctx);

      // Prepare funcStartLogger function
      ArrayRef<Type *> funcStartParamTypes = {
          builder.getInt8Ty()->getPointerTo()};
      FunctionType *funcStartLogFuncType =
          FunctionType::get(retType, funcStartParamTypes, false);
      FunctionCallee funcStartLogFunc = F.getParent()->getOrInsertFunction(
          "funcStartLogger", funcStartLogFuncType);

      // Insert a call to funcStartLogger function in the function begin
      BasicBlock &entryBB = F.getEntryBlock();
      builder.SetInsertPoint(&entryBB.front());
      Value *funcName = builder.CreateGlobalStringPtr(F.getName());
      Value *args[] = {funcName};
      builder.CreateCall(funcStartLogFunc, args);

      // Prepare funcEndLogger function
      ArrayRef<Type *> endParamTypes = {builder.getInt8Ty()->getPointerTo(),
                                        Type::getInt64Ty(Ctx)};
      FunctionType *endLogFuncType =
          FunctionType::get(retType, endParamTypes, false);
      FunctionCallee funcEndLogFunc =
          F.getParent()->getOrInsertFunction("funcEndLogger", endLogFuncType);

      // Prepare Logger for all uncaught instructions
      ArrayRef<Type *> logAllParamTypes = {
          builder.getInt8Ty()->getPointerTo()};
      FunctionType *logAllFuncType =
          FunctionType::get(retType, logAllParamTypes, false);
      FunctionCallee logAllFunc = F.getParent()->getOrInsertFunction(
          "logAll", logAllFuncType);

      // Default LoggerFuncType definition
      ArrayRef<Type *> DefaultParamTypes = {builder.getInt8Ty()->getPointerTo(),
                                            builder.getInt8Ty()->getPointerTo(),
                                            Type::getInt64Ty(Ctx)};
      FunctionType *DefaultLogFuncType =
          FunctionType::get(retType, DefaultParamTypes, false);

      // Prepare callLogger function
      FunctionCallee callLogFunc =
          F.getParent()->getOrInsertFunction("callLogger", DefaultLogFuncType);

      // Prepare condBranchLogger function
      FunctionCallee condBranchLogFunc =
          F.getParent()->getOrInsertFunction("condBranchLogger", DefaultLogFuncType);

      // Prepare uncondBranchLogger function
      FunctionCallee uncondBranchLogFunc =
          F.getParent()->getOrInsertFunction("uncondBranchLogger", DefaultLogFuncType);

      // Prepare cmpLogger function
      FunctionCallee cmpOptLogFunc =
          F.getParent()->getOrInsertFunction("cmpLogger", DefaultLogFuncType);

      // Prepare binOptLogger function
      FunctionCallee binOptLogFunc =
          F.getParent()->getOrInsertFunction("binOptLogger", DefaultLogFuncType);

      // Prepare castOptLogger function
      FunctionCallee castLogFunc =
          F.getParent()->getOrInsertFunction("castLogger", DefaultLogFuncType);

      // Prepare allocLogger function
      FunctionCallee allocLogFunc =
          F.getParent()->getOrInsertFunction("allocOptLogger", DefaultLogFuncType);

      // Prepare getelemptrLogger function
      FunctionCallee getelemptrLogFunc =
          F.getParent()->getOrInsertFunction("getelemptrLogger", DefaultLogFuncType);

      // Prepare unOptLogger function
      FunctionCallee unOptLogFunc =
          F.getParent()->getOrInsertFunction("unOptLogger", DefaultLogFuncType);

      // Prepare storeLogger function
      FunctionCallee storeLogFunc = F.getParent()->getOrInsertFunction(
          "storeLogger", DefaultLogFuncType);

      // Prepare loadLogger function
      FunctionCallee loadLogFunc = F.getParent()->getOrInsertFunction(
          "loadLogger", DefaultLogFuncType);

      // Insert loggers for call, binOpt and ret instructions
      for (auto &B : F)
      {
        for (auto &I : B)
        {
          Value *valueAddr =
              ConstantInt::get(builder.getInt64Ty(), (int64_t)(&I));
          
          if (auto *op = dyn_cast<PHINode>(&I)) {
            continue;
          }
          else if (auto *call = dyn_cast<CallInst>(&I))
          {
            builder.SetInsertPoint(call);

            Function *callee = call->getCalledFunction();
            if (callee && !isFuncLogger(callee->getName()))
            {
              Value *calleeName =
                  builder.CreateGlobalStringPtr(callee->getName());
              Value *funcName = builder.CreateGlobalStringPtr(F.getName());
              Value *args[] = {funcName, calleeName, valueAddr};
              builder.CreateCall(callLogFunc, args);
            }
          }
          else if (auto *ret = dyn_cast<ReturnInst>(&I))
          {
            builder.SetInsertPoint(ret);

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *args[] = {funcName, valueAddr};
            builder.CreateCall(funcEndLogFunc, args);
          }
          else if (auto *op = dyn_cast<BranchInst>(&I))
          {
            builder.SetInsertPoint(op);

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};

            if (op->isUnconditional())
            {
              builder.CreateCall(uncondBranchLogFunc, args);
            }
            if (op->isConditional())
            {
              builder.CreateCall(condBranchLogFunc, args);
            }
          }
          else if (auto *op = dyn_cast<CmpInst>(&I))
          {
            builder.SetInsertPoint(op);
            builder.SetInsertPoint(&B, ++builder.GetInsertPoint());

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getPredicateName(op->getPredicate()));
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(cmpOptLogFunc, args);
          }
          else if (auto *op = dyn_cast<BinaryOperator>(&I))
          {
            builder.SetInsertPoint(op);
            builder.SetInsertPoint(&B, ++builder.GetInsertPoint());

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(binOptLogFunc, args);
          }
          else if (auto *op = dyn_cast<CastInst>(&I))
          {
            builder.SetInsertPoint(op);

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getOpcodeName());

            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(castLogFunc, args);
          }
          else if (auto *store = dyn_cast<StoreInst>(&I))
          {
            builder.SetInsertPoint(store);

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(store->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(storeLogFunc, args);
          }
          else if (auto *load = dyn_cast<LoadInst>(&I))
          {
            builder.SetInsertPoint(load);

            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(load->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(loadLogFunc, args);
          }
          else if (auto *op = dyn_cast<UnaryInstruction>(&I)) // alloca
          {
            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(allocLogFunc, args);
          }
          else if (auto *op = dyn_cast<GetElementPtrInst>(&I))
          {
            Value *funcName = builder.CreateGlobalStringPtr(F.getName());
            Value *opName = builder.CreateGlobalStringPtr(op->getOpcodeName());
            Value *args[] = {funcName, opName, valueAddr};
            builder.CreateCall(getelemptrLogFunc, args);
          }
          else
          {
            std::string InstStr;
            raw_string_ostream InstStream(InstStr);
            I.print(InstStream);

            Value *InstStrValue = builder.CreateGlobalStringPtr(InstStr);
            CallInst::Create(logAllFunc, {InstStrValue}, "", &I);
          }
        }
      }
      return true;
    }
  };
} // namespace

char MyPass::ID = 0;

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerMyPass(const PassManagerBuilder &,
                           legacy::PassManagerBase &PM)
{
  PM.add(new MyPass());
}
static RegisterStandardPasses
    RegisterMyPass(PassManagerBuilder::EP_OptimizerLast,
                   registerMyPass);
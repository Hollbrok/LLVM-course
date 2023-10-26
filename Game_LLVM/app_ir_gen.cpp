#include <assert.h>
#include <SDL2/SDL.h>
#include <time.h>
#include "../Game/lib.h"

#define FRAME_TICKS 50

static SDL_Renderer *Renderer = NULL;
static SDL_Window *Window = NULL;
static SDL_Rect Cell;

static Uint32 Ticks = 0;

void GameInit();

void GameInit() {
    SDL_Init(SDL_INIT_VIDEO);
    SDL_CreateWindowAndRenderer(GRID_X * CELL_SIZE, GRID_Y * CELL_SIZE, 0, &Window, &Renderer);
    SDL_SetRenderDrawColor(Renderer, 0, 0, 0, 0);
    SDL_RenderClear(Renderer);

    Cell.w = CELL_SIZE;
    Cell.h = CELL_SIZE;
    srand(time(NULL));
}

int randomgen(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

int Lib_CountAliveNeighbors(int grid[GRID_Y][GRID_X], int x, int y) {
    int aliveNeighbors = 0;

    int offsetsX[] = { -1, 0, 1, -1, 1, -1, 0, 1 };
    int offsetsY[] = { -1, -1, -1, 0, 0, 1, 1, 1 };

    for (int i = 0; i < 8; ++i) {
        int neighborX = x + offsetsX[i];
        int neighborY = y + offsetsY[i];

        if (neighborX >= 0 && neighborX < GRID_X && neighborY >= 0 && neighborY < GRID_Y) {
            if (grid[neighborX][neighborY] == 1) {
                aliveNeighbors++;
            }
        }
    }

    return aliveNeighbors;
}

void Lib_DrawCell(int x, int y, int color) {
    Cell.x = x * CELL_SIZE;
    Cell.y = y * CELL_SIZE;
    if (color) {// black
        SDL_SetRenderDrawColor(Renderer, 255, 255, 255, 255);
    } else {
        SDL_SetRenderDrawColor(Renderer, 0, 0, 0, 0);
    }
    
    // Render rect
    SDL_RenderFillRect(Renderer, &Cell);
}

void Lib_Display() {
    SDL_PumpEvents();
    assert(SDL_TRUE != SDL_HasEvent(SDL_QUIT) && "User-requested quit");
    Uint32 cur_ticks = SDL_GetTicks() - Ticks;
    if (cur_ticks < FRAME_TICKS)
    {
        SDL_Delay(FRAME_TICKS - cur_ticks);
    }
    SDL_RenderPresent(Renderer);
}

int Lib_Rand(int min, int max) {
    return randomgen(min, max);
}
























#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

int main()
{
    LLVMContext context;
    // ; ModuleID = 'app.c'
    // source_filename = "app.c"
    Module *module = new Module("app.c", context);
    IRBuilder<> builder(context);
    // Attribute builder tool
    AttrBuilder attr_builder{};

    // declare dso_local i32 @Lib_Rand(i32, i32) local_unnamed_addr #2
    Type *voidType = Type::getVoidTy(context);
    ArrayType *row_120_Type = ArrayType::get(Type::getInt32Ty(context), 120);
    
    FunctionType *libRandType = FunctionType::get(builder.getInt32Ty(), {builder.getInt32Ty(), builder.getInt32Ty()}, false);
    FunctionCallee libRandFunc = module->getOrInsertFunction("Lib_Rand", libRandType);

    // declare dso_local void @Lib_DrawCell(i32, i32, i32) local_unnamed_addr #2
    FunctionType *libDrawCellType = FunctionType::get(voidType, {builder.getInt32Ty(), builder.getInt32Ty(), builder.getInt32Ty()}, false);
    FunctionCallee libDrawCellFunc = module->getOrInsertFunction("Lib_DrawCell", libDrawCellType);

    // declare dso_local void @Lib_Display(...) local_unnamed_addr #2

    FunctionType *libDisplayFuncType = FunctionType::get(builder.getVoidTy(), /* isVarArg */ true);
    FunctionCallee libDisplayFunc = module->getOrInsertFunction("Lib_Display", libDisplayFuncType);


    // declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1
    ArrayRef<Type *> llvm_lifetime_start_ParamTypes = {builder.getInt64Ty(),
                                                       builder.getInt8Ty()->getPointerTo()};
    FunctionType *llvm_lifetime_start_Type =
        FunctionType::get(builder.getVoidTy(), llvm_lifetime_start_ParamTypes, false);
    
    FunctionCallee llvm_lifetime_start_p0i8_Func =
        module->getOrInsertFunction("llvm.lifetime.start.p0i8", llvm_lifetime_start_Type);
    FunctionCallee llvm_lifetime_end_p0i8_Func =
        module->getOrInsertFunction("llvm.lifetime.end.p0i8", llvm_lifetime_start_Type);

    // declare void @llvm.memset.p0i8.i64
    ArrayRef<Type *> llvm_memset_ParamTypes = {
        builder.getInt8Ty()->getPointerTo(),
        builder.getInt8Ty(),
        builder.getInt64Ty(),
        builder.getInt1Ty(),
    };
    FunctionType *llvm_memset_Type =
        FunctionType::get(builder.getVoidTy(), llvm_memset_ParamTypes, false);
    FunctionCallee llvm_memset_Func =
        module->getOrInsertFunction("llvm.memset.p0i8.i64", llvm_memset_Type);

    // declare dso_local i32 @Lib_CountAliveNeighbors([120 x i32]*, i32, i32) local_unnamed_addr #2
    ArrayRef<Type *> Lib_CountAliveNeighbors_ParamTypes = {
        row_120_Type, builder.getInt32Ty(),
        builder.getInt32Ty(),
    };
    FunctionType *Lib_CountAliveNeighbors_Type =
        FunctionType::get(builder.getInt32Ty(), Lib_CountAliveNeighbors_ParamTypes, false);
    FunctionCallee Lib_CountAliveNeighbors_Func =
        module->getOrInsertFunction("Lib_CountAliveNeighbors", Lib_CountAliveNeighbors_Type);

    // define dso_local void @app() local_unnamed_addr #0 {
    FunctionType *appFuncType = FunctionType::get(builder.getVoidTy(), false);
    Function *appFunc =
        Function::Create(appFuncType, Function::ExternalLinkage, "app", module);

    // BasicBlocks:
    BasicBlock *BB0 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB6 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB9 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB18 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB19 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB37 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB40 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB43 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB50 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB53 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB55 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB57 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB59 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB62 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB80 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB81 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB84 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB85 = BasicBlock::Create(context, "", appFunc);
    BasicBlock *BB88 = BasicBlock::Create(context, "", appFunc);

    //  #########################  BB 0  #########################
    builder.SetInsertPoint(BB0);
    // %1 = alloca [120 x [120 x i32]], align 16
    Value *alloca1 = builder.CreateAlloca(ArrayType::get(ArrayType::get(builder.getInt32Ty(), 120), 120), nullptr);
    // %2 = alloca [120 x [120 x i32]], align 16
    Value *alloca2 = builder.CreateAlloca(ArrayType::get(ArrayType::get(builder.getInt32Ty(), 120), 120), nullptr);

    // %3 = bitcast [120 x [120 x i32]]* %2 to i8*
    Value *bitcast3 = builder.CreateBitCast(alloca2, builder.getInt8PtrTy());

    // Call llvm.lifetime.start.p0i8
    Value *lifetimeStartArgs[] = {builder.getInt64(57600), bitcast3};
    builder.CreateCall(module->getFunction("llvm.lifetime.start.p0i8"), lifetimeStartArgs);

    // Call llvm.memset.p0i8.i64
    Value *memsetArgs[] = {bitcast3, builder.getInt8(0), builder.getInt64(57600), builder.getInt1(false)};
    builder.CreateCall(module->getFunction("llvm.memset.p0i8.i64"), memsetArgs);

    // %4 = call i32 @Lib_Rand(i32 1000, i32 2000)
    Value *libRandArgs[] = {builder.getInt32(1000), builder.getInt32(2000)};
    Value *callLibRand = builder.CreateCall(libRandFunc, libRandArgs);

    // %5 = icmp sgt i32 %4, 0
    Value *icmp5 = builder.CreateICmpSGT(callLibRand, builder.getInt32(0));

    // br i1 %5, label %9, label %6
    builder.CreateCondBr(icmp5, BB9, BB6);

    //  #########################  BB 6  #########################
    builder.SetInsertPoint(BB6);
    // %7 = bitcast [120 x [120 x i32]]* %1 to i8*
    Value *bitcast7 = builder.CreateBitCast(alloca1, builder.getInt8PtrTy());
    // %8 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 0
    Value *indices1[] = {builder.getInt64(0), builder.getInt64(0)};
    Value *getelementptr8 = builder.CreateGEP(alloca2, indices1);
    builder.CreateBr(BB18);

    //  #########################  BB 9  #########################
    builder.SetInsertPoint(BB9);
    // %10 = phi i32 [ %16, %9 ], [ 0, %0 ]
    PHINode *phi10 = builder.CreatePHI(builder.getInt32Ty(), 2);

    // %11 = tail call i32 @Lib_Rand(i32 0, i32 119) #3
    Value *libRandArgs2[] = {builder.getInt32(0), builder.getInt32(119)};
    Value *callLibRand2 = builder.CreateCall(libRandFunc, libRandArgs2);

    // %12 = tail call i32 @Lib_Rand(i32 0, i32 119) #3
    Value *libRandArgs3[] = {builder.getInt32(0), builder.getInt32(119)};
    Value *callLibRand3 = builder.CreateCall(libRandFunc, libRandArgs3);

    // %13 = sext i32 %12 to i64
    Value *sext13 = builder.CreateSExt(callLibRand3, builder.getInt64Ty());

    // %14 = sext i32 %11 to i64
    Value *sext14 = builder.CreateSExt(callLibRand2, builder.getInt64Ty());

    // %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %14
    Value *indices2[] = {builder.getInt64(0), sext13, sext14};
    Value *getelementptr15 = builder.CreateGEP(alloca2, indices2);

    // store i32 1, i32* %15, align 4, !tbaa !2
    builder.CreateStore(builder.getInt32(1), getelementptr15);

    // %16 = add nuw nsw i32 %10, 1
    Value *add16 = builder.CreateNUWAdd(phi10, builder.getInt32(1));

    // %17 = icmp eq i32 %16, %4
    Value *icmp17 = builder.CreateICmpEQ(add16, callLibRand);

    // br i1 %17, label %6, label %9
    builder.CreateCondBr(icmp17, BB6, BB9);

    // Link PHI nodes
    // %10 = phi i32 [ %16, %9 ], [ 0, %0 ]
    phi10->addIncoming(add16, BB9);
    phi10->addIncoming(builder.getInt32(0), BB0);

    //  #########################  BB 18  #########################
    builder.SetInsertPoint(BB18);

    // call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %7)
    Value *llvmLifetimeStartArgs[] = {builder.getInt64(57600), bitcast7};
    FunctionType *llvmLifetimeStartType = FunctionType::get(builder.getVoidTy(), {builder.getInt64Ty(), builder.getInt8PtrTy()}, false);
    FunctionCallee llvmLifetimeStartFunc = module->getOrInsertFunction("llvm.lifetime.start.p0i8", llvmLifetimeStartType);
    builder.CreateCall(llvmLifetimeStartFunc, llvmLifetimeStartArgs);

    // br label %19
    builder.CreateBr(BB19);

    //  #########################  BB 19  #########################
    builder.SetInsertPoint(BB19);

    // %20 = phi i64 [ 0, %18 ], [ %35, %19 ]
    PHINode *val20 = builder.CreatePHI(builder.getInt64Ty(), 2);

    // %21 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %20, i64 0
    Value *gep21Indices[] = {builder.getInt64(0), val20, builder.getInt64(0)};
    Value *gep21 = builder.CreateGEP(alloca1, gep21Indices);

    // %22 = bitcast i32* %21 to i8*
    Value *bitcast22 = builder.CreateBitCast(gep21, builder.getInt8PtrTy());

    // %23 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %20, i64 0
    Value *gep23 = builder.CreateGEP(alloca2, gep21Indices);

    // %24 = bitcast i32* %23 to i8*
    Value *bitcast24 = builder.CreateBitCast(gep23, builder.getInt8PtrTy());

    // call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %22, i8* nonnull align 16 dereferenceable(480) %24, i64 480, i1 false) #3
    Value *memcpyArgs[] = {
        bitcast22,
        bitcast24,
        builder.getInt64(480),
        builder.getInt1(false)
    };
    FunctionType *memcpyType = FunctionType::get(builder.getVoidTy(), {builder.getInt8PtrTy(), builder.getInt8PtrTy(), builder.getInt64Ty(), builder.getInt1Ty()}, false);
    FunctionCallee memcpyFunc = module->getOrInsertFunction("llvm.memcpy.p0i8.p0i8.i64", memcpyType);
    builder.CreateCall(memcpyFunc, memcpyArgs);

    // %25 = add nuw nsw i64 %20, 1
    Value *val25 = builder.CreateNUWAdd(val20, builder.getInt64(1));

    // %26 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %25, i64 0
    Value *gep26Indices[] = {builder.getInt64(0), val25, builder.getInt64(0)};
    Value *gep26 = builder.CreateGEP(alloca1, gep26Indices);

    // %27 = bitcast i32* %26 to i8*
    Value *bitcast27 = builder.CreateBitCast(gep26, builder.getInt8PtrTy());

    // %28 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %25, i64 0
    Value *gep28 = builder.CreateGEP(alloca2, gep26Indices);

    // %29 = bitcast i32* %28 to i8*
    Value *bitcast29 = builder.CreateBitCast(gep28, builder.getInt8PtrTy());

    // call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %27, i8* nonnull align 16 dereferenceable(480) %29, i64 480, i1 false) #3
    Value *memcpyArgs2[] = {
        bitcast27,
        bitcast29,
        builder.getInt64(480),
        builder.getInt1(false)
    };
    FunctionCallee memcpyFunc2 = module->getOrInsertFunction("llvm.memcpy.p0i8.p0i8.i64", memcpyType);
    builder.CreateCall(memcpyFunc2, memcpyArgs2);

    // %30 = add nuw nsw i64 %20, 2
    Value *val30 = builder.CreateNUWAdd(val20, builder.getInt64(2));

    // %31 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %30, i64 0
    Value *gep31Indices[] = {builder.getInt64(0), val30, builder.getInt64(0)};
    Value *gep31 = builder.CreateGEP(alloca1, gep31Indices);

    // %32 = bitcast i32* %31 to i8*
    Value *bitcast32 = builder.CreateBitCast(gep31, builder.getInt8PtrTy());

    // %33 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %30, i64 0
    Value *gep33 = builder.CreateGEP(alloca2, gep31Indices);

    // %34 = bitcast i32* %33 to i8*
    Value *bitcast34 = builder.CreateBitCast(gep33, builder.getInt8PtrTy());

    // call void @llvm.memcpy.p0i8.p0i8.i64(i8* nonnull align 16 dereferenceable(480) %32, i8* nonnull align 16 dereferenceable(480) %34, i64 480, i1 false) #3
    Value *memcpyArgs3[] = {
        bitcast32,
        bitcast34,
        builder.getInt64(480),
        builder.getInt1(false)
    };
    FunctionCallee memcpyFunc3 = module->getOrInsertFunction("llvm.memcpy.p0i8.p0i8.i64", memcpyType);
    builder.CreateCall(memcpyFunc3, memcpyArgs3);

    // %35 = add nuw nsw i64 %20, 3
    Value *val35 = builder.CreateNUWAdd(val20, builder.getInt64(3));

    // %36 = icmp eq i64 %35, 120
    Value *icmp36 = builder.CreateICmpEQ(val35, builder.getInt64(120));

    // br i1 %36, label %37, label %19
    builder.CreateCondBr(icmp36, BB37, BB19);

    // Link PHI nodes
    val20->addIncoming(builder.getInt64(0), BB18);
    val20->addIncoming(val35, BB19);

    //  #########################  BB 37  #########################
    builder.SetInsertPoint(BB37);

    // %38 = phi i64 [ %41, %40 ], [ 0, %19 ]
    PHINode *val38 = builder.CreatePHI(builder.getInt64Ty(), 2);


    // %39 = trunc i64 %38 to i32
    Value *val39 = builder.CreateTrunc(val38, builder.getInt32Ty());

    // br label %43
    builder.CreateBr(BB43);

    //  #########################  BB 40  #########################
    builder.SetInsertPoint(BB40);

    // %41 = add nuw nsw i64 %38, 1
    Value *val41 = builder.CreateNUWAdd(val38, builder.getInt64(1));

    // %42 = icmp eq i64 %41, 120
    Value *val42 = builder.CreateICmpEQ(val41, builder.getInt64(120));

    // Link PHI nodes
    val38->addIncoming(val41, BB40);
    val38->addIncoming(builder.getInt64(0), BB19);

    // br i1 %42, label %62, label %37
    Value* test = builder.CreateCondBr(val42, BB62, BB37);


    //  #########################  BB 43  #########################
    builder.SetInsertPoint(BB43);
    // %44 = phi i64 [ 0, %37 ], [ %60, %59 ]
    PHINode *val44 = builder.CreatePHI(builder.getInt64Ty(), 2);


    // %45 = trunc i64 %44 to i32
    Value *val45 = builder.CreateTrunc(val44, builder.getInt32Ty());

    // %46 = call i32 @Lib_CountAliveNeighbors([120 x i32]* nonnull %8, i32 %39, i32 %45) #3
    Value *args[] = {getelementptr8, val39, val45};
    Value *val46 = builder.CreateCall(Lib_CountAliveNeighbors_Func, args);

    // %47 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %38, i64 %44
    Value *indices3[] = {builder.getInt64(0), val38, val44};
    Value *val47 = builder.CreateGEP(alloca2, indices3);

    // %48 = load i32, i32* %47, align 4, !tbaa !2
    Value *val48 = builder.CreateLoad(val47);

    // %49 = icmp eq i32 %48, 1
    Value *val49 = builder.CreateICmpEQ(val48, builder.getInt32(1));

    // br i1 %49, label %50, label %55
    builder.CreateCondBr(val49, BB50, BB55);

    //  #########################  BB 50  #########################
    builder.SetInsertPoint(BB50);
    
    // %51 = and i32 %46, -2
    Value *val51 = builder.CreateAnd(val46, builder.getInt32(-2));

    // %52 = icmp eq i32 %51, 2
    Value *val52 = builder.CreateICmpEQ(val51, builder.getInt32(2));

    // br i1 %52, label %59, label %53
    builder.CreateCondBr(val52, BB59, BB53);

    //  #########################  BB 53  #########################
    builder.SetInsertPoint(BB53);

    // %54 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %38, i64 %44
    Value *indices53[] = {builder.getInt64(0), val38, val44};
    Value *val54 = builder.CreateGEP(alloca1, indices53);

    // store i32 0, i32* %54, align 4, !tbaa !2
    builder.CreateStore(builder.getInt32(0), val54);

    // br label %59
    builder.CreateBr(BB59);
    //  #########################  BB 55  #########################
    builder.SetInsertPoint(BB55);

    // %56 = icmp eq i32 %46, 3
    Value *val56 = builder.CreateICmpEQ(val46, builder.getInt32(3));

    // br i1 %56, label %57, label %59
    builder.CreateCondBr(val56, BB57, BB59);

    //  #########################  BB 57  #########################
    builder.SetInsertPoint(BB57);

    // %58 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %38, i64 %44
    Value *indices[] = {builder.getInt64(0), val38, val44};
    Value *val58 = builder.CreateGEP(alloca1, indices);

    // store i32 1, i32* %58, align 4, !tbaa !2
    builder.CreateStore(builder.getInt32(1), val58);

    // br label %59
    builder.CreateBr(BB59);

    //  #########################  BB 59  #########################
    builder.SetInsertPoint(BB59);

    // %60 = add nuw nsw i64 %44, 1
    Value *val60 = builder.CreateNUWAdd(val44, builder.getInt64(1));

    // %61 = icmp eq i64 %60, 120
    Value *val61 = builder.CreateICmpEQ(val60, builder.getInt64(120));

    // br i1 %61, label %40, label %43
    builder.CreateCondBr(val61, BB40, BB43);

    //  #########################  BB 62  #########################
    builder.SetInsertPoint(BB62);

    // %63 = phi i64 [ %78, %62 ], [ 0, %40 ]
    PHINode *val63 = builder.CreatePHI(builder.getInt64Ty(), 2);
    
    // 
    val44->addIncoming(builder.getInt64(0), BB37);
    val44->addIncoming(val60, BB59);

    // %64 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %63, i64 0
    Value *indices64[] = {builder.getInt64(0), val63, builder.getInt64(0)};
    Value *val64 = builder.CreateGEP(alloca2, indices64);

    // %65 = bitcast i32* %64 to i8*
    Value *val65 = builder.CreateBitCast(val64, builder.getInt8PtrTy());

    // %66 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %63, i64 0
    Value *indices66[] = {builder.getInt64(0), val63, builder.getInt64(0)};
    Value *val66 = builder.CreateGEP(alloca1, indices66);

    // %67 = bitcast i32* %66 to i8*
    Value *val67 = builder.CreateBitCast(val66, builder.getInt8PtrTy());

    // Call to llvm.memcpy
    Value *argsMemcpy[] = {val65, val67, builder.getInt64(480), builder.getInt1(false)};
    builder.CreateCall(memcpyFunc, argsMemcpy);

    // %68 = add nuw nsw i64 %63, 1
    Value *val68 = builder.CreateNUWAdd(val63, builder.getInt64(1));

    // %69 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %68, i64 0
    Value *indices69[] = {builder.getInt64(0), val68, builder.getInt64(0)};
    Value *val69 = builder.CreateGEP(alloca2, indices69);

    // %70 = bitcast i32* %69 to i8*
    Value *val70 = builder.CreateBitCast(val69, builder.getInt8PtrTy());

    // %71 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %68, i64 0
    Value *indices71[] = {builder.getInt64(0), val68, builder.getInt64(0)};
    Value *val71 = builder.CreateGEP(alloca1, indices71);

    // %72 = bitcast i32* %71 to i8*
    Value *val72 = builder.CreateBitCast(val71, builder.getInt8PtrTy());

    // Call to llvm.memcpy
    Value *argsMemcpy2[] = {val70, val72, builder.getInt64(480), builder.getInt1(false)};
    builder.CreateCall(memcpyFunc, argsMemcpy2);

    // %73 = add nuw nsw i64 %63, 2
    Value *val73 = builder.CreateNUWAdd(val63, builder.getInt64(2));

    // %74 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %73, i64 0
    Value *indices74[] = {builder.getInt64(0), val73, builder.getInt64(0)};
    Value *val74 = builder.CreateGEP(alloca2, indices74);

    // %75 = bitcast i32* %74 to i8*
    Value *val75 = builder.CreateBitCast(val74, builder.getInt8PtrTy());

    // %76 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %73, i64 0
    Value *indices76[] = {builder.getInt64(0), val73, builder.getInt64(0)};
    Value *val76 = builder.CreateGEP(alloca1, indices76);

    // %77 = bitcast i32* %76 to i8*
    Value *val77 = builder.CreateBitCast(val76, builder.getInt8PtrTy());

    // Call to llvm.memcpy
    Value *argsMemcpy3[] = {val75, val77, builder.getInt64(480), builder.getInt1(false)};
    builder.CreateCall(memcpyFunc, argsMemcpy3);

    // %78 = add nuw nsw i64 %63, 3
    Value *val78 = builder.CreateNUWAdd(val63, builder.getInt64(3));

    // %79 = icmp eq i64 %78, 120
    Value *val79 = builder.CreateICmpEQ(val78, builder.getInt64(120));

    // br i1 %79, label %80, label %62
    builder.CreateCondBr(val79, BB80, BB62);

    val63->addIncoming(val78, BB62);
    val63->addIncoming(builder.getInt64(0), BB40);

    //  #########################  BB 80  #########################
    builder.SetInsertPoint(BB80);

    // Call llvm.lifetime.end to end the lifetime of %7
    Value *lifetimeArgs[] = {builder.getInt64(57600), bitcast7};
    builder.CreateCall(llvm_lifetime_end_p0i8_Func, lifetimeArgs);

    // Branch to %81
    builder.CreateBr(BB81);

    //  #########################  BB 81  #########################
    builder.SetInsertPoint(BB81);

    // Create a phi node for %82
    PHINode *val82 = builder.CreatePHI(builder.getInt64Ty(), 2);


    // Truncate %82 to i32 to get %83
    Value *val83 = builder.CreateTrunc(val82, builder.getInt32Ty());

    // Branch to %88
    builder.CreateBr(BB88);

    //  #########################  BB 84  #########################
    builder.SetInsertPoint(BB84);

    // Call the @Lib_Display() function
    builder.CreateCall(libDisplayFunc);

    // Branch to %18
    builder.CreateBr(BB18);

    //  #########################  BB 85  #########################
    builder.SetInsertPoint(BB85);

    // %86 = add nuw nsw i64 %82, 1
    Value *val86 = builder.CreateNUWAdd(val82, builder.getInt64(1));

    // %87 = icmp eq i64 %86, 120
    Value *val87 = builder.CreateICmpEQ(val86, builder.getInt64(120));

    val82->addIncoming(builder.getInt64(0), BB80);
    val82->addIncoming(val86, BB85);

    // Conditional branch based on %87
    builder.CreateCondBr(val87, BB84, BB81);

    //  #########################  BB 88  #########################
    builder.SetInsertPoint(BB88);

    // Create a PHI node for %89
    PHINode *val89 = builder.CreatePHI(builder.getInt64Ty(), 2);

    // %90 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %82, i64 %89
    Value *indices90[] = {builder.getInt64(0), val82, val89};
    Value *val90 = builder.CreateGEP(alloca2, indices90);

    // %91 = load i32, i32* %90, align 4, !tbaa !2
    Value *val91 = builder.CreateLoad(val90);

    // %92 = trunc i64 %89 to i32
    Value *val92 = builder.CreateTrunc(val89, builder.getInt32Ty());

    // Call function @Lib_DrawCell(i32 %83, i32 %92, i32 %91)
    Value *args88[] = {val83, val92, val91};
    builder.CreateCall(libDrawCellFunc, args88);

    // %93 = add nuw nsw i64 %89, 1
    Value *val93 = builder.CreateNUWAdd(val89, builder.getInt64(1));

    val89->addIncoming(builder.getInt64(0), BB81);
    val89->addIncoming(val93, BB88); // Assuming val93 is defined in the previous basic block


    // %94 = icmp eq i64 %93, 120
    Value *val94 = builder.CreateICmpEQ(val93, builder.getInt64(120));

    // Conditional branch based on %94
    builder.CreateCondBr(val94, BB85, BB88);
    

    // Dump LLVM IR
    module->print(outs(), nullptr);

    // Interpreter of LLVM IR
    outs() << "Running code...\n";
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
    ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void * {
        if (fnName == "Lib_Rand") {
            return reinterpret_cast<void *>(Lib_Rand);
        }
        if (fnName == "Lib_DrawCell") {
            return reinterpret_cast<void *>(Lib_DrawCell);
        }
        if (fnName == "Lib_Display") {
            return reinterpret_cast<void *>(Lib_Display);
        }
        if (fnName == "Lib_CountAliveNeighbors") {
            return reinterpret_cast<void *>(Lib_CountAliveNeighbors);
        }
        return nullptr;
    });
    ee->finalizeObject();

    GameInit();

    ArrayRef<GenericValue> noargs;
    GenericValue v = ee->runFunction(appFunc, noargs);
    outs() << "Code was run.\n";

    // simExit();
    return EXIT_SUCCESS;
}
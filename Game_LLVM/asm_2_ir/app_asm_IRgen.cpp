#include <assert.h>
#include <SDL2/SDL.h>
#include <time.h>
#include "../../Game/lib.h"

#define FRAME_TICKS 50

static SDL_Renderer *Renderer = NULL;
static SDL_Window *Window = NULL;
static SDL_Rect Cell;

static Uint32 Ticks = 0;

void GameInit();

void GameInit()
{
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

int Lib_CountAliveNeighbors(int grid[GRID_Y][GRID_X], int x, int y)
{
    int aliveNeighbors = 0;

    int offsetsX[] = {-1, 0, 1, -1, 1, -1, 0, 1};
    int offsetsY[] = {-1, -1, -1, 0, 0, 1, 1, 1};

    for (int i = 0; i < 8; ++i)
    {
        int neighborX = x + offsetsX[i];
        int neighborY = y + offsetsY[i];

        if (neighborX >= 0 && neighborX < GRID_X && neighborY >= 0 && neighborY < GRID_Y)
        {
            if (grid[neighborX][neighborY] == 1)
            {
                aliveNeighbors++;
            }
        }
    }

    return aliveNeighbors;
}

void Lib_DrawCell(int x, int y, int color)
{
    Cell.x = x * CELL_SIZE;
    Cell.y = y * CELL_SIZE;
    if (color)
    { // black
        SDL_SetRenderDrawColor(Renderer, 255, 255, 255, 255);
    }
    else
    {
        SDL_SetRenderDrawColor(Renderer, 0, 0, 0, 0);
    }

    // Render rect
    SDL_RenderFillRect(Renderer, &Cell);
}

void Lib_Display()
{
    SDL_PumpEvents();
    assert(SDL_TRUE != SDL_HasEvent(SDL_QUIT) && "User-requested quit");
    Uint32 cur_ticks = SDL_GetTicks() - Ticks;
    if (cur_ticks < FRAME_TICKS)
    {
        SDL_Delay(FRAME_TICKS - cur_ticks);
    }
    SDL_RenderPresent(Renderer);
}

int Lib_Rand(int min, int max)
{
    return randomgen(min, max);
}

void PrintGrid(int (*grid)[GRID_X][GRID_Y]) {
    printf("XXXXXXXXXXXX\n");
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            printf("%d ", (*grid)[x][y]);
        }
    }
    printf("##################\nDONE\n");
}


#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <fstream>
#include <iostream>
#include <unordered_map>
using namespace llvm;

const int REG_FILE_SIZE = 32;
uint64_t REG_FILE[REG_FILE_SIZE];

int COUNTER = 0;
void RegDump() {
    COUNTER++;
    printf("[!!] Counter: %d\n", COUNTER);
    
    printf("[!!] x1: %lu\n", REG_FILE[1]);
    printf("[!!] x2: %lu\n", REG_FILE[2]);
    printf("[!!] x5: %lu\n", REG_FILE[5]);
    printf("[!!] x6: %lu\n", REG_FILE[6]);
    printf("$$$$$$$$$$$$$$$$$\n");
 

    // if (!(COUNTER % 100)) {
    //     printf("[x] %d\n", COUNTER);
    // }
    // return;
    // for (int i = 0; i < REG_FILE_SIZE; ++i) {
    //     printf("x%d: %lu\n", i, REG_FILE[i]);
    // }
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        outs() << "[ERROR] Need 1 argument: file with RISC-V assembler\n";
        return 1;
    }
    std::ifstream input;
    input.open(argv[1]);
    if (!input.is_open())
    {
        outs() << "[ERROR] Can't open " << argv[1] << "\n";
        return 1;
    }

    LLVMContext context;
    // ; ModuleID = 'top'
    // source_filename = "top"
    Module *module = new Module("top", context);
    IRBuilder<> builder(context);

    std::string name;
    std::string arg;
    std::unordered_map<std::string, BasicBlock *> BBMap;

    //[32 x i64] regFile = {0, 0, 0, 0}
    ArrayType *regFileType = ArrayType::get(builder.getInt64Ty(), REG_FILE_SIZE);
    module->getOrInsertGlobal("regFile", regFileType);
    GlobalVariable *regFile = module->getNamedGlobal("regFile");

    // declare void @main()
    FunctionType *funcType = FunctionType::get(builder.getVoidTy(), false);
    Function *mainFunc =
        Function::Create(funcType, Function::ExternalLinkage, "main", module);

    outs() << "\n#[FILE]:\nAsm:\n";

    while (input >> name)
    {
#define FETCH_INSTR(instr) !name.compare(instr)
        if (FETCH_INSTR("GEP_DEFAULT") || FETCH_INSTR("GEP_LOAD") || FETCH_INSTR("GEP_STORE")
            || FETCH_INSTR("CNT_ALIVE") || FETCH_INSTR("EQ_SELECT"))
        {
            outs() << name << " ";

            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " " << "\n";
            continue;
        }
        if (FETCH_INSTR("RAND") || FETCH_INSTR("XOR") || FETCH_INSTR("SGT_BR") || FETCH_INSTR("RAND") || FETCH_INSTR("INC_EQ") ||
            FETCH_INSTR("BR_COND") || FETCH_INSTR("CMP_EQ") || FETCH_INSTR("EQ_BR") || FETCH_INSTR("DRAW"))
        {
            outs() << name << " ";

            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " " << "\n";
            continue;
        }
        if (FETCH_INSTR("BITCAST") || FETCH_INSTR("PTRTOINT") || FETCH_INSTR("TRUNC") ||
            FETCH_INSTR("STORE") || FETCH_INSTR("INTTOPTR") || FETCH_INSTR("GEP") || FETCH_INSTR("ZEXT") ||
            FETCH_INSTR("AND_EQ") || FETCH_INSTR("SWAP"))
        {
            outs() << name << " ";

            input >> arg;
            outs() << arg << " ";
            input >> arg;
            outs() << arg << " " << "\n";
            continue;
        }
        if (FETCH_INSTR("ALLOCATE") || FETCH_INSTR("LIFETIME_START") || FETCH_INSTR("BR") || FETCH_INSTR("INC")  || FETCH_INSTR("PRINT_GRID"))
        {
            outs() << name << " ";
            input >> arg;
            outs() << arg << " " << "\n";
            continue;
        }
        if (FETCH_INSTR("DISPLAY") || FETCH_INSTR("EXIT") || FETCH_INSTR("REG_DUMP"))
        {
            outs() << name << "\n";
            continue;
        }

        outs() << "BB: " << name << "\n";
        BBMap[name] = BasicBlock::Create(context, name, mainFunc);
    }
    outs() << "\n";
    input.close();
    input.open(argv[1]);

    // Funcions types
    // declare dso_local i32 @Lib_Rand(i32, i32) local_unnamed_addr #2
    Type *voidType = builder.getVoidTy();
    ArrayType *row_120_Type = ArrayType::get(builder.getInt32Ty(), 120);
    PointerType *row_120_p_Type = PointerType::get(row_120_Type, 0);

    ArrayType *row_120_120_Type = ArrayType::get(row_120_Type, 120);
    PointerType *row_120_120_p_Type = PointerType::get(row_120_120_Type, 0);

    FunctionType *libRandType = FunctionType::get(builder.getInt64Ty(), {builder.getInt32Ty(), builder.getInt32Ty()}, false);
    FunctionCallee libRandFunc = module->getOrInsertFunction("Lib_Rand", libRandType);

    // declare dso_local void @Lib_DrawCell(i32, i32, i32) local_unnamed_addr #2
    FunctionType *libDrawCellType = FunctionType::get(voidType, {builder.getInt32Ty(), builder.getInt32Ty(), builder.getInt32Ty()}, false);
    FunctionCallee libDrawCellFunc = module->getOrInsertFunction("Lib_DrawCell", libDrawCellType);

    // declare dso_local void @Lib_Display(...) local_unnamed_addr #2

    FunctionType *libDisplayFuncType = FunctionType::get(builder.getVoidTy(), /* isVarArg */ true);
    FunctionCallee libDisplayFunc = module->getOrInsertFunction("Lib_Display", libDisplayFuncType);

    FunctionType *RegDumpFuncType = FunctionType::get(builder.getVoidTy(), /* isVarArg */ false);
    FunctionCallee RegDumpFunc = module->getOrInsertFunction("RegDump", RegDumpFuncType);


    // declare dso_local i32 @Lib_CountAliveNeighbors([120 x i32]*, i32, i32) local_unnamed_addr #2
    ArrayRef<Type *> Lib_CountAliveNeighbors_ParamTypes = {
        row_120_p_Type,
        builder.getInt32Ty(),
        builder.getInt32Ty(),
    };
    FunctionType *Lib_CountAliveNeighbors_Type =
        FunctionType::get(builder.getInt32Ty(), Lib_CountAliveNeighbors_ParamTypes, false);
    FunctionCallee Lib_CountAliveNeighbors_Func =
        module->getOrInsertFunction("Lib_CountAliveNeighbors", Lib_CountAliveNeighbors_Type);

    // declare dso_local i32 @PrintGrid([120 x [120 x i32]]*) local_unnamed_addr #2
    ArrayRef<Type *> PrintGridParamTypes = {
        row_120_120_p_Type,
    };
    FunctionType *PrintGrid_Type =
        FunctionType::get(voidType, PrintGridParamTypes, false);
    FunctionCallee PrintGrid_Func =
        module->getOrInsertFunction("PrintGrid", PrintGrid_Type);


    // declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1
    ArrayRef<Type *> llvm_lifetime_start_ParamTypes = {builder.getInt64Ty(),
                                                       builder.getInt8Ty()->getPointerTo()};
    FunctionType *llvm_lifetime_start_Type =
        FunctionType::get(builder.getVoidTy(), llvm_lifetime_start_ParamTypes, false);

    FunctionCallee llvm_lifetime_start_p0i8_Func =
        module->getOrInsertFunction("llvm.lifetime.start.p0i8", llvm_lifetime_start_Type);

    // ASM -> IR part
    while (input >> name)
    {
        if (!name.compare("EXIT"))
        {
            outs() << "\tEXIT\n";

            builder.CreateRetVoid();
            if (input >> name)
            {
                outs() << "BB " << name << "\n";
                builder.SetInsertPoint(BBMap[name]);
            }
            continue;
        }
        if (!name.compare("REG_DUMP")) {
            builder.CreateCall(module->getFunction("RegDump"));
            continue;
        }
        if (!name.compare("PRINT_GRID"))
        {
            input >> arg;
            outs() << "\tPRINT_GRID: " << arg;
            // res
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            Value *PrintGridArgs[] = {builder.CreateLoad(row_120_120_p_Type, arg1_p)};
            Value *callCntRand = builder.CreateCall(module->getFunction("PrintGrid"), PrintGridArgs);
            continue;
        }
        if (!name.compare("INC"))
        {
            input >> arg;
            outs() << "\tINC: " << arg;
            // res
            Value *arg1 = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                     std::stoi(arg.substr(1)));
            Value *arg2 = builder.getInt32(1);
            Value *inc_arg1 =
                builder.CreateAdd(builder.CreateLoad(builder.getInt32Ty(), arg1), arg2);
            builder.CreateStore(inc_arg1, arg1);
            continue;
        }
        if (!name.compare("INC_EQ"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *arg1 =
                builder.CreateAdd(builder.CreateLoad(builder.getInt32Ty(), arg1_p),
                                  builder.getInt32(1));
            builder.CreateStore(arg1, arg1_p);
            input >> arg;
            outs() << " == " << arg << "\n";
            // arg2
            Value *arg2;
            Value *cond;
            if (arg[0] == 'x')
            { // 3rd argument is a register
                arg2 = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                  std::stoi(arg.substr(1)));
                cond = builder.CreateICmpEQ(arg1, builder.CreateLoad(builder.getInt32Ty(), arg2));
            }
            else
            { // 3rd argument is a number
                arg2 = builder.getInt32(std::stoi(arg));
                cond = builder.CreateICmpEQ(arg1, arg2);
            }
            // Value *arg2 = builder.getInt32(std::stoi(arg));
            // Value *cond = builder.CreateICmpEQ(arg1, arg2);
            builder.CreateStore(cond, res_p);
            continue;
        }
        if (!name.compare("DRAW"))
        {
            input >> arg;
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            Value *args[] = {builder.CreateLoad(builder.getInt32Ty(), arg1_p),
                             builder.CreateLoad(builder.getInt32Ty(), arg2_p),
                             builder.CreateLoad(builder.getInt32Ty(), arg3_p),};
            builder.CreateCall(libDrawCellFunc, args);
            continue;
        }
        if (!name.compare("ALLOCATE"))
        {
            input >> arg;
            outs() << "\tALLOCATE: " << arg << "\n";
            // res
            Value *arg1 = builder.CreateConstGEP2_64(regFileType, regFile, 0,
                                                     std::stoi(arg.substr(1)));
            llvm::AllocaInst *alloca = builder.CreateAlloca(ArrayType::get(ArrayType::get(builder.getInt32Ty(), 120), 120), nullptr);
            alloca->setAlignment(llvm::Align(16));
            builder.CreateStore(alloca, arg1);
            //Value *ptrtoint = builder.CreatePtrToInt(alloca, builder.getInt64Ty());
            //builder.CreateStore(ptrtoint, arg1);
            continue;
        }
        if (!name.compare("BITCAST"))
        {
            input >> arg;
            outs() << "\tBITCAST: " << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            outs() << " " << arg << "\n";
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            Value *bitcast = builder.CreateBitCast(builder.CreateLoad(row_120_120_p_Type, arg1_p), builder.getInt8PtrTy());
            builder.CreateStore(bitcast, res_p);
            continue;
        }
        if (!name.compare("LIFETIME_START"))
        {
            input >> arg;
            outs() << "\tLIFETIME_START: " << arg << "\n";
            // res
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *lifetimeStartArgs[] = {builder.getInt64(57600), builder.CreateLoad(builder.getInt8PtrTy(), arg1_p)};
            llvm::CallInst *lifetimeStartCall_instr = builder.CreateCall(module->getFunction("llvm.lifetime.start.p0i8"), lifetimeStartArgs);
            lifetimeStartCall_instr->addParamAttr(1, llvm::Attribute::NonNull);
            continue;
        }
        if (!name.compare("PTRTOINT"))
        {
            input >> arg;
            outs() << "\tPTRTOINT: " << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            outs() << " " << arg << "\n";
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *ptrtoint = builder.CreatePtrToInt(builder.CreateLoad(row_120_120_p_Type, arg1_p), builder.getInt64Ty());
            builder.CreateStore(ptrtoint, res_p);
            continue;
        }
        if (!name.compare("RAND"))
        {
            input >> arg;
            // outs() << "\tRAND: " << arg;
            //  res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg1 = builder.getInt32(std::stoi(arg));
            input >> arg;
            Value *arg2 = builder.getInt32(std::stoi(arg));

            Value *libRandArgs[] = {arg1, arg2};
            Value *callLibRand = builder.CreateCall(module->getFunction("Lib_Rand"), libRandArgs);

            builder.CreateStore(callLibRand, res_p);
            continue;
        }
        if (!name.compare("TRUNC"))
        {
            input >> arg;
            outs() << "\tTRUNC: " << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            outs() << " " << arg << "\n";
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *trunc = builder.CreateTrunc(builder.CreateLoad(builder.getInt64Ty(), arg1_p), builder.getInt32Ty());
            builder.CreateStore(trunc, res_p);
            continue;
        }
        if (!name.compare("DISPLAY"))
        {
            outs() << "\tDISPLAY\n";
            builder.CreateCall(libDisplayFunc);
            continue;
        }
        if (!name.compare("XOR"))
        {
            input >> arg;
            outs() << "\t" << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            outs() << " = " << arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            outs() << " ^ " << arg << "\n";
            // arg2
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *xor_arg1_arg2 =
                builder.CreateXor(builder.CreateLoad(builder.getInt64Ty(), arg1_p),
                                  builder.CreateLoad(builder.getInt64Ty(), arg2_p));
            builder.CreateStore(xor_arg1_arg2, res_p);
            continue;
        }
        if (!name.compare("SGT_BR"))
        {
            input >> arg;
            outs() << "\tSGT_BR" << arg << "\n";
            // res
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *icmp_sgt = builder.CreateICmpSGT(builder.CreateLoad(builder.getInt32Ty(), arg1_p), builder.getInt32(0));
            input >> arg;
            input >> name;
            builder.CreateCondBr(icmp_sgt,
                                 BBMap[arg], BBMap[name]);
            builder.SetInsertPoint(BBMap[arg]);
            // builder.SetInsertPoint(BBMap[name]);
            continue;
        }
        if (!name.compare("GEP_DEFAULT"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            // arg2
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            input >> arg;
            // arg2
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            // %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %14
            Value *gep_args[] = {builder.getInt64(0), builder.CreateLoad(builder.getInt64Ty(), arg2_p), builder.CreateLoad(builder.getInt64Ty(), arg3_p)};
            Value *getelementptr = builder.CreateInBoundsGEP(builder.CreateLoad(row_120_120_p_Type, arg1_p),
                                                             gep_args);
            builder.CreateStore(getelementptr, res_p);
            continue;
        }
        if (!name.compare("STORE"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            // arg1
            Value *arg1 = builder.getInt32(std::stoi(arg));

            builder.CreateStore(arg1, builder.CreateLoad(PointerType::get(builder.getInt32Ty(), 0), res_p));
            continue;
        }
        if (!name.compare("INTTOPTR"))
        {
            input >> arg;
            outs() << "\tINTTOPTR: " << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *inttoptr = builder.CreateIntToPtr(builder.CreateLoad(builder.getInt64Ty(), arg1_p), row_120_120_p_Type);
            builder.CreateStore(inttoptr, res_p);
            continue;
        }
        if (!name.compare("GEP"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            // %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %22, i64 0, i64 0
            Value *gep_args[] = {builder.getInt64(0), builder.getInt64(0)};
            Value *getelementptr = builder.CreateInBoundsGEP(builder.CreateLoad(row_120_120_p_Type, arg1_p),
                                                             gep_args);
            builder.CreateStore(getelementptr, res_p);
            continue;
        }
        if (!name.compare("CNT_ALIVE"))
        {
            input >> arg;
            outs() << "\tCNT_ALIVE: " << arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            Value *libCntArgs[] = {builder.CreateLoad(row_120_p_Type, arg1_p),
                                   builder.CreateLoad(builder.getInt32Ty(), arg2_p),
                                   builder.CreateLoad(builder.getInt32Ty(), arg3_p)};
            Value *callCntRand = builder.CreateCall(module->getFunction("Lib_CountAliveNeighbors"), libCntArgs);

            builder.CreateStore(callCntRand, res_p);
            continue;
        }
        if (!name.compare("GEP_LOAD"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            // arg2
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            input >> arg;
            // arg2
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            // %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %14
            Value *gep_args[] = {builder.getInt64(0), builder.CreateLoad(builder.getInt64Ty(), arg2_p), builder.CreateLoad(builder.getInt64Ty(), arg3_p)};
            Value *getelementptr = builder.CreateInBoundsGEP(builder.CreateLoad(row_120_120_p_Type, arg1_p),
                                                             gep_args);
            Value *load = builder.CreateLoad(builder.getInt32Ty(), getelementptr);
            builder.CreateStore(load, res_p);
            continue;
        }
        if (!name.compare("CMP_EQ"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            // arg2
            Value *arg2 = builder.getInt32(std::stoi(arg));
            ;

            Value *cond = builder.CreateICmpEQ(builder.CreateLoad(builder.getInt32Ty(), arg1_p), arg2);
            builder.CreateStore(cond, res_p);
            continue;
        }
        if (!name.compare("INC_EQ"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *add_result =
                builder.CreateAdd(builder.CreateLoad(builder.getInt32Ty(), arg1_p),
                                  builder.getInt32(1));
            builder.CreateStore(add_result, arg1_p);
            input >> arg;
            // arg2
            Value *arg2;
            Value *cond;
            if (arg[0] == 'x')
            { // 3rd argument is a register
                arg2 = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                  std::stoi(arg.substr(1)));
                cond = builder.CreateICmpEQ(add_result, builder.CreateLoad(builder.getInt32Ty(), arg2));
            }
            else
            { // 3rd argument is a number
                arg2 = builder.getInt32(std::stoi(arg));
                cond = builder.CreateICmpEQ(add_result, arg2);
            }
            // Value *arg2 = builder.getInt32(std::stoi(arg));
            // Value *cond = builder.CreateICmpEQ(arg1, arg2);
            builder.CreateStore(cond, res_p);
            continue;
        }
        if (!name.compare("AND_EQ"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *and_result =
                builder.CreateAnd(builder.CreateLoad(builder.getInt32Ty(), arg1_p),
                                  builder.getInt32(-2));

            Value *cond = builder.CreateICmpEQ(and_result, builder.getInt32(2));

            builder.CreateStore(cond, res_p);
            continue;
        }
        if (!name.compare("EQ_SELECT"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            // arg2
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            input >> arg;
            // arg2
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            Value *cond = builder.CreateICmpEQ(builder.CreateLoad(builder.getInt32Ty(), arg1_p), builder.getInt32(3));
            Value *select = builder.CreateSelect(builder.CreateLoad(builder.getInt1Ty(), arg2_p),
                                                 builder.CreateLoad(builder.getInt1Ty(), arg3_p),
                                                 cond);
                                            
            //Value *load = builder.CreateLoad(builder.getInt32Ty(), getelementptr);
            builder.CreateStore(select, res_p);
            continue;
        }
        if (!name.compare("ZEXT"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            Value* zext = builder.CreateZExt(builder.CreateLoad(builder.getInt1Ty(), arg1_p), builder.getInt32Ty());

            builder.CreateStore(zext, res_p);
            continue;
        }
        if (!name.compare("GEP_STORE"))
        {
            input >> arg;
            // res
            Value *res_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            input >> arg;
            // arg2
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            input >> arg;
            // arg2
            Value *arg3_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));

            // %15 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %14
            Value *gep_args[] = {builder.getInt64(0), builder.CreateLoad(builder.getInt64Ty(), arg2_p), builder.CreateLoad(builder.getInt64Ty(), arg3_p)};
            Value *getelementptr = builder.CreateInBoundsGEP(builder.CreateLoad(row_120_120_p_Type, arg1_p),
                                                             gep_args);
            builder.CreateStore(builder.CreateLoad(builder.getInt32Ty(), res_p), getelementptr);
            continue;
        }
        if (!name.compare("EQ_BR"))
        {
            input >> arg;
            // res
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            Value *icmp_eq = builder.CreateICmpEQ(builder.CreateLoad(builder.getInt64Ty(), arg1_p), builder.getInt64(120));
            input >> arg;
            input >> name;
            builder.CreateCondBr(icmp_eq,
                                 BBMap[arg], BBMap[name]);
            builder.SetInsertPoint(BBMap[arg]);
            // builder.SetInsertPoint(BBMap[name]);
            continue;
        }   
        if (!name.compare("SWAP"))
        {
            input >> arg;
            // res
            Value *arg2_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));

            input >> arg;
            // arg1
            Value *arg1_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                       std::stoi(arg.substr(1)));
            //tmp value
            Value *tmp1 =
                builder.CreateAdd(builder.CreateLoad(builder.getInt64Ty(), arg1_p),
                                  builder.getInt32(0));

            Value *tmp2 =
                builder.CreateAdd(builder.CreateLoad(builder.getInt64Ty(), arg2_p),
                                  builder.getInt32(0));
            
            builder.CreateStore(tmp1, arg2_p);
            builder.CreateStore(tmp2, arg1_p);
            continue;
        }
        if (!name.compare("BR"))
        {
            input >> name;
            builder.CreateBr(BBMap[name]);
            // builder.SetInsertPoint(BBMap[name]);
            continue;
        }
        if (!name.compare("BR_COND"))
        {
            input >> arg;
            // reg1
            Value *reg_p = builder.CreateConstGEP2_32(regFileType, regFile, 0,
                                                      std::stoi(arg.substr(1)));
            input >> arg;
            input >> name;
            builder.CreateCondBr(builder.CreateLoad(builder.getInt1Ty(), reg_p),
                                 BBMap[arg], BBMap[name]);
            builder.SetInsertPoint(BBMap[arg]);
            continue;
        }
        if (builder.GetInsertBlock())
        {
            // builder.CreateBr(BBMap[name]);
            outs() << "\tbranch to " << name << "\n";
        }
        outs() << "BB " << name << "\n";
        builder.SetInsertPoint(BBMap[name]);
    }

    outs() << "\n#[LLVM IR]:\n";
    module->print(outs(), nullptr);

    outs() << "\n#[Running code]\n";
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
    ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void *
                                   {
        if (fnName == "Lib_Display") {
            return reinterpret_cast<void *>(Lib_Display);
        }
        if (fnName == "Lib_Rand") {
            return reinterpret_cast<void *>(Lib_Rand);
        }
        if (fnName == "Lib_CountAliveNeighbors") {
            return reinterpret_cast<void *>(Lib_CountAliveNeighbors);
        }
        if (fnName == "Lib_DrawCell") {
            return reinterpret_cast<void *>(Lib_DrawCell);
        }
        if (fnName == "PrintGrid") {
            return reinterpret_cast<void *>(PrintGrid);
        }
        if (fnName == "RegDump") {
            return reinterpret_cast<void *>(RegDump);
        }
        return nullptr; });

    ee->addGlobalMapping(regFile, (void *)REG_FILE);
    ee->finalizeObject();
    GameInit();

    ArrayRef<GenericValue> noargs;
    printf("Before run\n");
    ee->runFunction(mainFunc, noargs);
    outs() << "\n[REG DUMP]:\n";
    for (int i = 0; i < REG_FILE_SIZE; ++i)
    {
        outs() << "x" << i << ": " << REG_FILE[i] << "\n";
    }
    outs() << "#[Code was run]\n";

    return EXIT_SUCCESS;
}

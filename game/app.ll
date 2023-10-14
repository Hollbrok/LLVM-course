; ModuleID = 'app.bc'
source_filename = "app.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"0\0A\00", align 1
@__const.CountAliveNeighbors.offsetsX = private unnamed_addr constant [8 x i32] [i32 -1, i32 0, i32 1, i32 -1, i32 1, i32 -1, i32 0, i32 1], align 16
@__const.CountAliveNeighbors.offsetsY = private unnamed_addr constant [8 x i32] [i32 -1, i32 -1, i32 -1, i32 0, i32 0, i32 1, i32 1, i32 1], align 16

; Function Attrs: noinline nounwind uwtable
define dso_local void @InitGrid([120 x i32]* %grid) #0 {
entry:
  %grid.addr = alloca [120 x i32]*, align 8
  %cellNumber = alloca i32, align 4
  %i = alloca i32, align 4
  %y = alloca i32, align 4
  %x = alloca i32, align 4
  store [120 x i32]* %grid, [120 x i32]** %grid.addr, align 8
  %call = call i32 @Lib_Rand(i32 1000, i32 2000)
  store i32 %call, i32* %cellNumber, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0))
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %cellNumber, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call2 = call i32 @Lib_Rand(i32 0, i32 119)
  store i32 %call2, i32* %y, align 4
  %call3 = call i32 @Lib_Rand(i32 0, i32 119)
  store i32 %call3, i32* %x, align 4
  %2 = load [120 x i32]*, [120 x i32]** %grid.addr, align 8
  %3 = load i32, i32* %x, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [120 x i32], [120 x i32]* %2, i64 %idxprom
  %4 = load i32, i32* %y, align 4
  %idxprom4 = sext i32 %4 to i64
  %arrayidx5 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx, i64 0, i64 %idxprom4
  store i32 1, i32* %arrayidx5, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret void
}

declare dso_local i32 @Lib_Rand(i32, i32) #1

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @CountAliveNeighbors([120 x i32]* %grid, i32 %x, i32 %y) #0 {
entry:
  %grid.addr = alloca [120 x i32]*, align 8
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %aliveNeighbors = alloca i32, align 4
  %offsetsX = alloca [8 x i32], align 16
  %offsetsY = alloca [8 x i32], align 16
  %i = alloca i32, align 4
  %neighborX = alloca i32, align 4
  %neighborY = alloca i32, align 4
  store [120 x i32]* %grid, [120 x i32]** %grid.addr, align 8
  store i32 %x, i32* %x.addr, align 4
  store i32 %y, i32* %y.addr, align 4
  store i32 0, i32* %aliveNeighbors, align 4
  %0 = bitcast [8 x i32]* %offsetsX to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %0, i8* align 16 bitcast ([8 x i32]* @__const.CountAliveNeighbors.offsetsX to i8*), i64 32, i1 false)
  %1 = bitcast [8 x i32]* %offsetsY to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 16 %1, i8* align 16 bitcast ([8 x i32]* @__const.CountAliveNeighbors.offsetsY to i8*), i64 32, i1 false)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %2 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %2, 8
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %x.addr, align 4
  %4 = load i32, i32* %i, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [8 x i32], [8 x i32]* %offsetsX, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx, align 4
  %add = add nsw i32 %3, %5
  store i32 %add, i32* %neighborX, align 4
  %6 = load i32, i32* %y.addr, align 4
  %7 = load i32, i32* %i, align 4
  %idxprom1 = sext i32 %7 to i64
  %arrayidx2 = getelementptr inbounds [8 x i32], [8 x i32]* %offsetsY, i64 0, i64 %idxprom1
  %8 = load i32, i32* %arrayidx2, align 4
  %add3 = add nsw i32 %6, %8
  store i32 %add3, i32* %neighborY, align 4
  %9 = load i32, i32* %neighborX, align 4
  %cmp4 = icmp sge i32 %9, 0
  br i1 %cmp4, label %land.lhs.true, label %if.end16

land.lhs.true:                                    ; preds = %for.body
  %10 = load i32, i32* %neighborX, align 4
  %cmp5 = icmp slt i32 %10, 120
  br i1 %cmp5, label %land.lhs.true6, label %if.end16

land.lhs.true6:                                   ; preds = %land.lhs.true
  %11 = load i32, i32* %neighborY, align 4
  %cmp7 = icmp sge i32 %11, 0
  br i1 %cmp7, label %land.lhs.true8, label %if.end16

land.lhs.true8:                                   ; preds = %land.lhs.true6
  %12 = load i32, i32* %neighborY, align 4
  %cmp9 = icmp slt i32 %12, 120
  br i1 %cmp9, label %if.then, label %if.end16

if.then:                                          ; preds = %land.lhs.true8
  %13 = load [120 x i32]*, [120 x i32]** %grid.addr, align 8
  %14 = load i32, i32* %neighborX, align 4
  %idxprom10 = sext i32 %14 to i64
  %arrayidx11 = getelementptr inbounds [120 x i32], [120 x i32]* %13, i64 %idxprom10
  %15 = load i32, i32* %neighborY, align 4
  %idxprom12 = sext i32 %15 to i64
  %arrayidx13 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx11, i64 0, i64 %idxprom12
  %16 = load i32, i32* %arrayidx13, align 4
  %cmp14 = icmp eq i32 %16, 1
  br i1 %cmp14, label %if.then15, label %if.end

if.then15:                                        ; preds = %if.then
  %17 = load i32, i32* %aliveNeighbors, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %aliveNeighbors, align 4
  br label %if.end

if.end:                                           ; preds = %if.then15, %if.then
  br label %if.end16

if.end16:                                         ; preds = %if.end, %land.lhs.true8, %land.lhs.true6, %land.lhs.true, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end16
  %18 = load i32, i32* %i, align 4
  %inc17 = add nsw i32 %18, 1
  store i32 %inc17, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %19 = load i32, i32* %aliveNeighbors, align 4
  ret i32 %19
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @UpdateGrid([120 x [120 x i32]]* %grid) #0 {
entry:
  %grid.addr = alloca [120 x [120 x i32]]*, align 8
  %newGrid = alloca [120 x [120 x i32]], align 16
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %x13 = alloca i32, align 4
  %y17 = alloca i32, align 4
  %aliveNeighbors = alloca i32, align 4
  %x47 = alloca i32, align 4
  %y51 = alloca i32, align 4
  store [120 x [120 x i32]]* %grid, [120 x [120 x i32]]** %grid.addr, align 8
  store i32 0, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc10, %entry
  %0 = load i32, i32* %x, align 4
  %cmp = icmp slt i32 %0, 120
  br i1 %cmp, label %for.body, label %for.end12

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %y, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %y, align 4
  %cmp2 = icmp slt i32 %1, 120
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load [120 x [120 x i32]]*, [120 x [120 x i32]]** %grid.addr, align 8
  %3 = load i32, i32* %x, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %idxprom
  %4 = load i32, i32* %y, align 4
  %idxprom4 = sext i32 %4 to i64
  %arrayidx5 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx, i64 0, i64 %idxprom4
  %5 = load i32, i32* %arrayidx5, align 4
  %6 = load i32, i32* %x, align 4
  %idxprom6 = sext i32 %6 to i64
  %arrayidx7 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %idxprom6
  %7 = load i32, i32* %y, align 4
  %idxprom8 = sext i32 %7 to i64
  %arrayidx9 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx7, i64 0, i64 %idxprom8
  store i32 %5, i32* %arrayidx9, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %8 = load i32, i32* %y, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %y, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc10

for.inc10:                                        ; preds = %for.end
  %9 = load i32, i32* %x, align 4
  %inc11 = add nsw i32 %9, 1
  store i32 %inc11, i32* %x, align 4
  br label %for.cond

for.end12:                                        ; preds = %for.cond
  store i32 0, i32* %x13, align 4
  br label %for.cond14

for.cond14:                                       ; preds = %for.inc44, %for.end12
  %10 = load i32, i32* %x13, align 4
  %cmp15 = icmp slt i32 %10, 120
  br i1 %cmp15, label %for.body16, label %for.end46

for.body16:                                       ; preds = %for.cond14
  store i32 0, i32* %y17, align 4
  br label %for.cond18

for.cond18:                                       ; preds = %for.inc41, %for.body16
  %11 = load i32, i32* %y17, align 4
  %cmp19 = icmp slt i32 %11, 120
  br i1 %cmp19, label %for.body20, label %for.end43

for.body20:                                       ; preds = %for.cond18
  %12 = load [120 x [120 x i32]]*, [120 x [120 x i32]]** %grid.addr, align 8
  %arraydecay = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %12, i64 0, i64 0
  %13 = load i32, i32* %x13, align 4
  %14 = load i32, i32* %y17, align 4
  %call = call i32 @CountAliveNeighbors([120 x i32]* %arraydecay, i32 %13, i32 %14)
  store i32 %call, i32* %aliveNeighbors, align 4
  %15 = load [120 x [120 x i32]]*, [120 x [120 x i32]]** %grid.addr, align 8
  %16 = load i32, i32* %x13, align 4
  %idxprom21 = sext i32 %16 to i64
  %arrayidx22 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %15, i64 0, i64 %idxprom21
  %17 = load i32, i32* %y17, align 4
  %idxprom23 = sext i32 %17 to i64
  %arrayidx24 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx22, i64 0, i64 %idxprom23
  %18 = load i32, i32* %arrayidx24, align 4
  %cmp25 = icmp eq i32 %18, 1
  br i1 %cmp25, label %if.then, label %if.else

if.then:                                          ; preds = %for.body20
  %19 = load i32, i32* %aliveNeighbors, align 4
  %cmp26 = icmp slt i32 %19, 2
  br i1 %cmp26, label %if.then28, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then
  %20 = load i32, i32* %aliveNeighbors, align 4
  %cmp27 = icmp sgt i32 %20, 3
  br i1 %cmp27, label %if.then28, label %if.end

if.then28:                                        ; preds = %lor.lhs.false, %if.then
  %21 = load i32, i32* %x13, align 4
  %idxprom29 = sext i32 %21 to i64
  %arrayidx30 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %idxprom29
  %22 = load i32, i32* %y17, align 4
  %idxprom31 = sext i32 %22 to i64
  %arrayidx32 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx30, i64 0, i64 %idxprom31
  store i32 0, i32* %arrayidx32, align 4
  br label %if.end

if.end:                                           ; preds = %if.then28, %lor.lhs.false
  br label %if.end40

if.else:                                          ; preds = %for.body20
  %23 = load i32, i32* %aliveNeighbors, align 4
  %cmp33 = icmp eq i32 %23, 3
  br i1 %cmp33, label %if.then34, label %if.end39

if.then34:                                        ; preds = %if.else
  %24 = load i32, i32* %x13, align 4
  %idxprom35 = sext i32 %24 to i64
  %arrayidx36 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %idxprom35
  %25 = load i32, i32* %y17, align 4
  %idxprom37 = sext i32 %25 to i64
  %arrayidx38 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx36, i64 0, i64 %idxprom37
  store i32 1, i32* %arrayidx38, align 4
  br label %if.end39

if.end39:                                         ; preds = %if.then34, %if.else
  br label %if.end40

if.end40:                                         ; preds = %if.end39, %if.end
  br label %for.inc41

for.inc41:                                        ; preds = %if.end40
  %26 = load i32, i32* %y17, align 4
  %inc42 = add nsw i32 %26, 1
  store i32 %inc42, i32* %y17, align 4
  br label %for.cond18

for.end43:                                        ; preds = %for.cond18
  br label %for.inc44

for.inc44:                                        ; preds = %for.end43
  %27 = load i32, i32* %x13, align 4
  %inc45 = add nsw i32 %27, 1
  store i32 %inc45, i32* %x13, align 4
  br label %for.cond14

for.end46:                                        ; preds = %for.cond14
  store i32 0, i32* %x47, align 4
  br label %for.cond48

for.cond48:                                       ; preds = %for.inc66, %for.end46
  %28 = load i32, i32* %x47, align 4
  %cmp49 = icmp slt i32 %28, 120
  br i1 %cmp49, label %for.body50, label %for.end68

for.body50:                                       ; preds = %for.cond48
  store i32 0, i32* %y51, align 4
  br label %for.cond52

for.cond52:                                       ; preds = %for.inc63, %for.body50
  %29 = load i32, i32* %y51, align 4
  %cmp53 = icmp slt i32 %29, 120
  br i1 %cmp53, label %for.body54, label %for.end65

for.body54:                                       ; preds = %for.cond52
  %30 = load i32, i32* %x47, align 4
  %idxprom55 = sext i32 %30 to i64
  %arrayidx56 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %newGrid, i64 0, i64 %idxprom55
  %31 = load i32, i32* %y51, align 4
  %idxprom57 = sext i32 %31 to i64
  %arrayidx58 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx56, i64 0, i64 %idxprom57
  %32 = load i32, i32* %arrayidx58, align 4
  %33 = load [120 x [120 x i32]]*, [120 x [120 x i32]]** %grid.addr, align 8
  %34 = load i32, i32* %x47, align 4
  %idxprom59 = sext i32 %34 to i64
  %arrayidx60 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %33, i64 0, i64 %idxprom59
  %35 = load i32, i32* %y51, align 4
  %idxprom61 = sext i32 %35 to i64
  %arrayidx62 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx60, i64 0, i64 %idxprom61
  store i32 %32, i32* %arrayidx62, align 4
  br label %for.inc63

for.inc63:                                        ; preds = %for.body54
  %36 = load i32, i32* %y51, align 4
  %inc64 = add nsw i32 %36, 1
  store i32 %inc64, i32* %y51, align 4
  br label %for.cond52

for.end65:                                        ; preds = %for.cond52
  br label %for.inc66

for.inc66:                                        ; preds = %for.end65
  %37 = load i32, i32* %x47, align 4
  %inc67 = add nsw i32 %37, 1
  store i32 %inc67, i32* %x47, align 4
  br label %for.cond48

for.end68:                                        ; preds = %for.cond48
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @DrawGrid([120 x i32]* %grid) #0 {
entry:
  %grid.addr = alloca [120 x i32]*, align 8
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store [120 x i32]* %grid, [120 x i32]** %grid.addr, align 8
  store i32 0, i32* %x, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc6, %entry
  %0 = load i32, i32* %x, align 4
  %cmp = icmp slt i32 %0, 120
  br i1 %cmp, label %for.body, label %for.end8

for.body:                                         ; preds = %for.cond
  store i32 0, i32* %y, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %y, align 4
  %cmp2 = icmp slt i32 %1, 120
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %x, align 4
  %3 = load i32, i32* %y, align 4
  %4 = load [120 x i32]*, [120 x i32]** %grid.addr, align 8
  %5 = load i32, i32* %x, align 4
  %idxprom = sext i32 %5 to i64
  %arrayidx = getelementptr inbounds [120 x i32], [120 x i32]* %4, i64 %idxprom
  %6 = load i32, i32* %y, align 4
  %idxprom4 = sext i32 %6 to i64
  %arrayidx5 = getelementptr inbounds [120 x i32], [120 x i32]* %arrayidx, i64 0, i64 %idxprom4
  %7 = load i32, i32* %arrayidx5, align 4
  call void @Lib_DrawCell(i32 %2, i32 %3, i32 %7)
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %8 = load i32, i32* %y, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %y, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.inc6

for.inc6:                                         ; preds = %for.end
  %9 = load i32, i32* %x, align 4
  %inc7 = add nsw i32 %9, 1
  store i32 %inc7, i32* %x, align 4
  br label %for.cond

for.end8:                                         ; preds = %for.cond
  ret void
}

declare dso_local void @Lib_DrawCell(i32, i32, i32) #1

; Function Attrs: noinline nounwind uwtable
define dso_local void @app() #0 {
entry:
  %grid = alloca [120 x [120 x i32]], align 16
  %0 = bitcast [120 x [120 x i32]]* %grid to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %0, i8 0, i64 57600, i1 false)
  %arraydecay = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  call void @InitGrid([120 x i32]* %arraydecay)
  br label %while.body

while.body:                                       ; preds = %entry, %while.body
  call void @UpdateGrid([120 x [120 x i32]]* %grid)
  %arraydecay1 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %grid, i64 0, i64 0
  call void @DrawGrid([120 x i32]* %arraydecay1)
  call void (...) @Lib_Display()
  br label %while.body
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

declare dso_local void @Lib_Display(...) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind willreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0-4ubuntu1 "}

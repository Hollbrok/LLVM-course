; ModuleID = 'top'
source_filename = "top"

@regFile = external global [32 x i64]

define void @main() {
label0:
  %0 = alloca [120 x [120 x i32]], align 16
  store [120 x [120 x i32]]* %0, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i64 0, i64 1)
  %1 = alloca [120 x [120 x i32]], align 16
  store [120 x [120 x i32]]* %1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i64 0, i64 2)
  %2 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 1)
  %3 = bitcast [120 x [120 x i32]]* %2 to i8*
  store i8* %3, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 3)
  %4 = load i8*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 3)
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %4)
  %5 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 2)
  %6 = bitcast [120 x [120 x i32]]* %5 to i8*
  store i8* %6, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 4)
  %7 = load i8*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 4)
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* nonnull %7)
  %8 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 1)
  %9 = ptrtoint [120 x [120 x i32]]* %8 to i64
  store i64 %9, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 5)
  %10 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 2)
  %11 = ptrtoint [120 x [120 x i32]]* %10 to i64
  store i64 %11, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 6)
  %12 = call i64 @Lib_Rand(i32 1000, i32 5000)
  store i64 %12, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 7)
  %13 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 7)
  %14 = trunc i64 %13 to i32
  store i32 %14, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 7)
  %15 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 8)
  %16 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 8)
  %17 = xor i64 %15, %16
  store i64 %17, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 8)
  %18 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 7)
  %19 = icmp sgt i32 %18, 0
  br i1 %19, label %label10, label %label18

label10:                                          ; preds = %label10, %label0
  %20 = call i64 @Lib_Rand(i32 0, i32 119)
  store i64 %20, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 9)
  %21 = call i64 @Lib_Rand(i32 0, i32 119)
  store i64 %21, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 10)
  %22 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 10)
  %23 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 9)
  %24 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 1)
  %25 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %24, i64 0, i64 %22, i64 %23
  store i32* %25, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 11)
  %26 = load i32*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 11)
  store i32 1, i32* %26
  %27 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 10)
  %28 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 9)
  %29 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 2)
  %30 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %29, i64 0, i64 %27, i64 %28
  store i32* %30, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 12)
  %31 = load i32*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 12)
  store i32 0, i32* %31
  %32 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 8)
  %33 = add i32 %32, 1
  store i32 %33, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 8)
  %34 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 7)
  %35 = icmp eq i32 %33, %34
  store i1 %35, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 0)
  %36 = load i1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 0)
  br i1 %36, label %label18, label %label10

label18:                                          ; preds = %label10, %label0
  br label %label19

label19:                                          ; preds = %label59, %label18
  %37 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 5)
  %38 = inttoptr i64 %37 to [120 x [120 x i32]]*
  store [120 x [120 x i32]]* %38, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 13)
  %39 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 6)
  %40 = inttoptr i64 %39 to [120 x [120 x i32]]*
  store [120 x [120 x i32]]* %40, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 14)
  %41 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 13)
  %42 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %41, i64 0, i64 0
  store [120 x i32]* %42, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 15)
  %43 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %44 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %45 = xor i64 %43, %44
  store i64 %45, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  br label %label25

label25:                                          ; preds = %label28, %label19
  %46 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %47 = trunc i64 %46 to i32
  store i32 %47, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 17)
  %48 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %49 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %50 = xor i64 %48, %49
  store i64 %50, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  br label %label31

label28:                                          ; preds = %label31
  %51 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %52 = add i32 %51, 1
  store i32 %52, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %53 = icmp eq i32 %52, 120
  store i1 %53, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 31)
  %54 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %55 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %56 = xor i64 %54, %55
  store i64 %56, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %57 = load i1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 31)
  br i1 %57, label %label46, label %label25

label31:                                          ; preds = %label31, %label25
  %58 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %59 = trunc i64 %58 to i32
  store i32 %59, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 19)
  %60 = load [120 x i32]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 15)
  %61 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 17)
  %62 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 19)
  %63 = call i32 @Lib_CountAliveNeighbors([120 x i32]* %60, i32 %61, i32 %62)
  store i32 %63, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 20)
  %64 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %65 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %66 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 13)
  %67 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %66, i64 0, i64 %64, i64 %65
  %68 = load i32, i32* %67
  store i32 %68, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 21)
  %69 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 21)
  %70 = icmp eq i32 %69, 1
  store i1 %70, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 22)
  %71 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 20)
  %72 = and i32 %71, -2
  %73 = icmp eq i32 %72, 2
  store i1 %73, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 23)
  %74 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 20)
  %75 = icmp eq i32 %74, 3
  %76 = load i1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 22)
  %77 = load i1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 23)
  %78 = select i1 %76, i1 %77, i1 %75
  store i1 %78, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 24)
  %79 = load i1, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 24)
  %80 = zext i1 %79 to i32
  store i32 %80, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 25)
  %81 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 16)
  %82 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %83 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 14)
  %84 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %83, i64 0, i64 %81, i64 %82
  %85 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 25)
  store i32 %85, i32* %84
  %86 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %87 = add i32 %86, 1
  store i32 %87, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %88 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 18)
  %89 = icmp eq i64 %88, 120
  br i1 %89, label %label28, label %label31

label46:                                          ; preds = %label49, %label28
  %90 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %91 = trunc i64 %90 to i32
  store i32 %91, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 28)
  %92 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %93 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %94 = xor i64 %92, %93
  store i64 %94, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  br label %label52

label49:                                          ; preds = %label52
  %95 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %96 = add i32 %95, 1
  store i32 %96, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %97 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %98 = icmp eq i64 %97, 120
  br i1 %98, label %label59, label %label46

label52:                                          ; preds = %label52, %label46
  %99 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 27)
  %100 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %101 = load [120 x [120 x i32]]*, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 14)
  %102 = getelementptr inbounds [120 x [120 x i32]], [120 x [120 x i32]]* %101, i64 0, i64 %99, i64 %100
  %103 = load i32, i32* %102
  store i32 %103, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 26)
  %104 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %105 = trunc i64 %104 to i32
  store i32 %105, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 29)
  %106 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 28)
  %107 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 29)
  %108 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 26)
  call void @Lib_DrawCell(i32 %106, i32 %107, i32 %108)
  %109 = load i32, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %110 = add i32 %109, 1
  store i32 %110, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %111 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 30)
  %112 = icmp eq i64 %111, 120
  br i1 %112, label %label49, label %label52

label59:                                          ; preds = %label49
  call void (...) @Lib_Display()
  %113 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 6)
  %114 = add i64 %113, i32 0
  %115 = load i64, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 5)
  %116 = add i64 %115, i32 0
  store i64 %114, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 5)
  store i64 %116, i64* getelementptr inbounds ([32 x i64], [32 x i64]* @regFile, i32 0, i32 6)
  br label %label19

exit:                                             ; No predecessors!
  ret void
}

declare i64 @Lib_Rand(i32, i32)

declare void @Lib_DrawCell(i32, i32, i32)

declare void @Lib_Display(...)

declare void @RegDump()

declare i32 @Lib_CountAliveNeighbors([120 x i32]*, i32, i32)

declare void @PrintGrid([120 x [120 x i32]]*)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #0

attributes #0 = { argmemonly nounwind willreturn }
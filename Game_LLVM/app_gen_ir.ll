; ModuleID = 'app.c'
source_filename = "app.c"

declare i32 @Lib_Rand(i32, i32)

declare void @Lib_DrawCell(i32, i32, i32)

declare void @Lib_Display(...)

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #0

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #0

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #0

declare i32 @Lib_CountAliveNeighbors([120 x i32], i32, i32)

define void @app() {
  %1 = alloca [120 x [120 x i32]]
  %2 = alloca [120 x [120 x i32]]
  %3 = bitcast [120 x [120 x i32]]* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* %3)
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 57600, i1 false)
  %4 = call i32 @Lib_Rand(i32 1000, i32 2000)
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %9, label %6

6:                                                ; preds = %9, %0
  %7 = bitcast [120 x [120 x i32]]* %1 to i8*
  %8 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 0
  br label %18

9:                                                ; preds = %9, %0
  %10 = phi i32 [ %16, %9 ], [ 0, %0 ]
  %11 = call i32 @Lib_Rand(i32 0, i32 119)
  %12 = call i32 @Lib_Rand(i32 0, i32 119)
  %13 = sext i32 %12 to i64
  %14 = sext i32 %11 to i64
  %15 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %13, i64 %14
  store i32 1, i32* %15
  %16 = add nuw i32 %10, 1
  %17 = icmp eq i32 %16, %4
  br i1 %17, label %6, label %9

18:                                               ; preds = %84, %6
  call void @llvm.lifetime.start.p0i8(i64 57600, i8* %7)
  br label %19

19:                                               ; preds = %19, %18
  %20 = phi i64 [ 0, %18 ], [ %35, %19 ]
  %21 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %20, i64 0
  %22 = bitcast i32* %21 to i8*
  %23 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %20, i64 0
  %24 = bitcast i32* %23 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %22, i8* %24, i64 480, i1 false)
  %25 = add nuw i64 %20, 1
  %26 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %25, i64 0
  %27 = bitcast i32* %26 to i8*
  %28 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %25, i64 0
  %29 = bitcast i32* %28 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %29, i64 480, i1 false)
  %30 = add nuw i64 %20, 2
  %31 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %30, i64 0
  %32 = bitcast i32* %31 to i8*
  %33 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %30, i64 0
  %34 = bitcast i32* %33 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %32, i8* %34, i64 480, i1 false)
  %35 = add nuw i64 %20, 3
  %36 = icmp eq i64 %35, 120
  br i1 %36, label %37, label %19

37:                                               ; preds = %40, %19
  %38 = phi i64 [ %41, %40 ], [ 0, %19 ]
  %39 = trunc i64 %38 to i32
  br label %43

40:                                               ; preds = %59
  %41 = add nuw i64 %38, 1
  %42 = icmp eq i64 %41, 120
  br i1 %42, label %62, label %37

43:                                               ; preds = %59, %37
  %44 = phi i64 [ 0, %37 ], [ %60, %59 ]
  %45 = trunc i64 %44 to i32
  %46 = call i32 @Lib_CountAliveNeighbors([120 x i32]* %8, i32 %39, i32 %45)
  %47 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %38, i64 %44
  %48 = load i32, i32* %47
  %49 = icmp eq i32 %48, 1
  br i1 %49, label %50, label %55

50:                                               ; preds = %43
  %51 = and i32 %46, -2
  %52 = icmp eq i32 %51, 2
  br i1 %52, label %59, label %53

53:                                               ; preds = %50
  %54 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %38, i64 %44
  store i32 0, i32* %54
  br label %59

55:                                               ; preds = %43
  %56 = icmp eq i32 %46, 3
  br i1 %56, label %57, label %59

57:                                               ; preds = %55
  %58 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %38, i64 %44
  store i32 1, i32* %58
  br label %59

59:                                               ; preds = %57, %55, %53, %50
  %60 = add nuw i64 %44, 1
  %61 = icmp eq i64 %60, 120
  br i1 %61, label %40, label %43

62:                                               ; preds = %62, %40
  %63 = phi i64 [ %78, %62 ], [ 0, %40 ]
  %64 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %63, i64 0
  %65 = bitcast i32* %64 to i8*
  %66 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %63, i64 0
  %67 = bitcast i32* %66 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %65, i8* %67, i64 480, i1 false)
  %68 = add nuw i64 %63, 1
  %69 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %68, i64 0
  %70 = bitcast i32* %69 to i8*
  %71 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %68, i64 0
  %72 = bitcast i32* %71 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %70, i8* %72, i64 480, i1 false)
  %73 = add nuw i64 %63, 2
  %74 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %73, i64 0
  %75 = bitcast i32* %74 to i8*
  %76 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %1, i64 0, i64 %73, i64 0
  %77 = bitcast i32* %76 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %75, i8* %77, i64 480, i1 false)
  %78 = add nuw i64 %63, 3
  %79 = icmp eq i64 %78, 120
  br i1 %79, label %80, label %62

80:                                               ; preds = %62
  call void @llvm.lifetime.end.p0i8(i64 57600, i8* %7)
  br label %81

81:                                               ; preds = %85, %80
  %82 = phi i64 [ 0, %80 ], [ %86, %85 ]
  %83 = trunc i64 %82 to i32
  br label %88

84:                                               ; preds = %85
  call void (...) @Lib_Display()
  br label %18

85:                                               ; preds = %88
  %86 = add nuw i64 %82, 1
  %87 = icmp eq i64 %86, 120
  br i1 %87, label %84, label %81

88:                                               ; preds = %88, %81
  %89 = phi i64 [ 0, %81 ], [ %93, %88 ]
  %90 = getelementptr [120 x [120 x i32]], [120 x [120 x i32]]* %2, i64 0, i64 %82, i64 %89
  %91 = load i32, i32* %90
  %92 = trunc i64 %89 to i32
  call void @Lib_DrawCell(i32 %83, i32 %92, i32 %91)
  %93 = add nuw i64 %89, 1
  %94 = icmp eq i64 %93, 120
  br i1 %94, label %85, label %88
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { argmemonly nounwind willreturn }

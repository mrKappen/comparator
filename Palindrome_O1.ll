; ModuleID = 'service.c'
source_filename = "service.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [32 x i8] c"\0AWelcome to Palindrome Finder\0A\0A\00", align 1
@.str.1 = private unnamed_addr constant [38 x i8] c"\09Please enter a possible palindrome: \00", align 1
@.str.2 = private unnamed_addr constant [34 x i8] c"\09\09Nope, that's not a palindrome\0A\0A\00", align 1
@.str.3 = private unnamed_addr constant [30 x i8] c"\09\09Yes, that's a palindrome!\0A\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"\0A\0AEASTER EGG!\0A\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 %0, i8** nocapture readnone %1) local_unnamed_addr #0 {
  %3 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str, i64 0, i64 0), i64 31) #4
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %2
  %6 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.1, i64 0, i64 0), i64 37) #4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %10, label %9

8:                                                ; preds = %2
  call void @cgc__terminate(i32 0) #5
  unreachable

9:                                                ; preds = %20, %5
  call void @cgc__terminate(i32 0) #5
  unreachable

10:                                               ; preds = %5, %20
  %11 = call i32 @cgc_check()
  switch i32 %11, label %16 [
    i32 -1, label %23
    i32 0, label %12
  ]

12:                                               ; preds = %10
  %13 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i64 33) #4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %20, label %15

15:                                               ; preds = %12
  call void @cgc__terminate(i32 0) #5
  unreachable

16:                                               ; preds = %10
  %17 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.3, i64 0, i64 0), i64 29) #4
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %20, label %19

19:                                               ; preds = %16
  call void @cgc__terminate(i32 0) #5
  unreachable

20:                                               ; preds = %12, %16
  %21 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.1, i64 0, i64 0), i64 37) #4
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %10, label %9

23:                                               ; preds = %10
  ret i32 0
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

declare dso_local i32 @cgc_transmit_all(i32, i8*, i64) local_unnamed_addr #2

; Function Attrs: noreturn
declare dso_local void @cgc__terminate(i32) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define dso_local i32 @cgc_check() local_unnamed_addr #0 {
  %1 = alloca [64 x i8], align 16
  %2 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 0
  %3 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 64, i8* nonnull %3) #4
  call void @llvm.memset.p0i8.i64(i8* nonnull align 16 dereferenceable(64) %2, i8 0, i64 64, i1 false)
  %4 = call i32 @cgc_receive_delim(i32 0, i8* nonnull %3, i64 128, i8 signext 10) #4
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %51

6:                                                ; preds = %0
  %7 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 0
  %8 = load i8, i8* %7, align 16, !tbaa !2
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %18, label %10

10:                                               ; preds = %6, %10
  %11 = phi i64 [ %14, %10 ], [ 0, %6 ]
  %12 = phi i32 [ %13, %10 ], [ -1, %6 ]
  %13 = add nsw i32 %12, 1
  %14 = add nuw i64 %11, 1
  %15 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 %14
  %16 = load i8, i8* %15, align 1, !tbaa !2
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %18, label %10

18:                                               ; preds = %10, %6
  %19 = phi i32 [ -1, %6 ], [ %13, %10 ]
  %20 = srem i32 %19, 2
  %21 = icmp eq i32 %20, 1
  %22 = sext i1 %21 to i32
  %23 = add nsw i32 %19, %22
  %24 = icmp slt i32 %23, -1
  br i1 %24, label %43, label %25

25:                                               ; preds = %18
  %26 = sdiv i32 %23, 2
  %27 = sext i32 %19 to i64
  %28 = add nsw i32 %26, 1
  %29 = zext i32 %28 to i64
  br label %30

30:                                               ; preds = %30, %25
  %31 = phi i64 [ 0, %25 ], [ %41, %30 ]
  %32 = phi i32 [ 1, %25 ], [ %40, %30 ]
  %33 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 %31
  %34 = load i8, i8* %33, align 1, !tbaa !2
  %35 = xor i64 %31, -1
  %36 = add nsw i64 %27, %35
  %37 = getelementptr inbounds [64 x i8], [64 x i8]* %1, i64 0, i64 %36
  %38 = load i8, i8* %37, align 1, !tbaa !2
  %39 = icmp eq i8 %34, %38
  %40 = select i1 %39, i32 %32, i32 0
  %41 = add nuw nsw i64 %31, 1
  %42 = icmp eq i64 %41, %29
  br i1 %42, label %43, label %30

43:                                               ; preds = %30, %18
  %44 = phi i32 [ 1, %18 ], [ %40, %30 ]
  %45 = load i8, i8* %3, align 16, !tbaa !2
  %46 = icmp eq i8 %45, 94
  br i1 %46, label %47, label %51

47:                                               ; preds = %43
  %48 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i64 0, i64 0), i64 15) #4
  %49 = icmp eq i32 %48, 0
  br i1 %49, label %51, label %50

50:                                               ; preds = %47
  call void @cgc__terminate(i32 0) #5
  unreachable

51:                                               ; preds = %43, %47, %0
  %52 = phi i32 [ -1, %0 ], [ %44, %47 ], [ %44, %43 ]
  call void @llvm.lifetime.end.p0i8(i64 64, i8* nonnull %3) #4
  ret i32 %52
}

declare dso_local i32 @cgc_receive_delim(i32, i8*, i64, i8 signext) local_unnamed_addr #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}

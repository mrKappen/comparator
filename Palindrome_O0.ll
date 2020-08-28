; ModuleID = 'service.c'
source_filename = "service.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [32 x i8] c"\0AWelcome to Palindrome Finder\0A\0A\00", align 1
@.str.1 = private unnamed_addr constant [38 x i8] c"\09Please enter a possible palindrome: \00", align 1
@.str.2 = private unnamed_addr constant [34 x i8] c"\09\09Nope, that's not a palindrome\0A\0A\00", align 1
@.str.3 = private unnamed_addr constant [30 x i8] c"\09\09Yes, that's a palindrome!\0A\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"\0A\0AEASTER EGG!\0A\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %7 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str, i64 0, i64 0), i64 31)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  call void @cgc__terminate(i32 0) #3
  unreachable

10:                                               ; preds = %2
  br label %11

11:                                               ; preds = %10, %34
  %12 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.1, i64 0, i64 0), i64 37)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  call void @cgc__terminate(i32 0) #3
  unreachable

15:                                               ; preds = %11
  %16 = call i32 @cgc_check()
  store i32 %16, i32* %6, align 4
  %17 = load i32, i32* %6, align 4
  %18 = icmp eq i32 %17, -1
  br i1 %18, label %19, label %20

19:                                               ; preds = %15
  br label %35

20:                                               ; preds = %15
  %21 = load i32, i32* %6, align 4
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %28

23:                                               ; preds = %20
  %24 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.2, i64 0, i64 0), i64 33)
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %27

26:                                               ; preds = %23
  call void @cgc__terminate(i32 0) #3
  unreachable

27:                                               ; preds = %23
  br label %33

28:                                               ; preds = %20
  %29 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.3, i64 0, i64 0), i64 29)
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %32

31:                                               ; preds = %28
  call void @cgc__terminate(i32 0) #3
  unreachable

32:                                               ; preds = %28
  br label %33

33:                                               ; preds = %32, %27
  br label %34

34:                                               ; preds = %33
  br label %11

35:                                               ; preds = %19
  ret i32 0
}

declare dso_local i32 @cgc_transmit_all(i32, i8*, i64) #1

; Function Attrs: noreturn
declare dso_local void @cgc__terminate(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @cgc_check() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca [64 x i8], align 16
  %6 = alloca i32, align 4
  store i32 -1, i32* %2, align 4
  store i32 1, i32* %4, align 4
  store i32 0, i32* %3, align 4
  br label %7

7:                                                ; preds = %15, %0
  %8 = load i32, i32* %3, align 4
  %9 = sext i32 %8 to i64
  %10 = icmp ult i64 %9, 64
  br i1 %10, label %11, label %18

11:                                               ; preds = %7
  %12 = load i32, i32* %3, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 %13
  store i8 0, i8* %14, align 1
  br label %15

15:                                               ; preds = %11
  %16 = load i32, i32* %3, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %3, align 4
  br label %7

18:                                               ; preds = %7
  %19 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 0
  %20 = call i32 @cgc_receive_delim(i32 0, i8* %19, i64 128, i8 signext 10)
  %21 = icmp ne i32 %20, 0
  br i1 %21, label %22, label %23

22:                                               ; preds = %18
  store i32 -1, i32* %1, align 4
  br label %83

23:                                               ; preds = %18
  store i32 0, i32* %3, align 4
  br label %24

24:                                               ; preds = %34, %23
  %25 = load i32, i32* %3, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 %26
  %28 = load i8, i8* %27, align 1
  %29 = sext i8 %28 to i32
  %30 = icmp ne i32 %29, 0
  br i1 %30, label %31, label %37

31:                                               ; preds = %24
  %32 = load i32, i32* %2, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %2, align 4
  br label %34

34:                                               ; preds = %31
  %35 = load i32, i32* %3, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %3, align 4
  br label %24

37:                                               ; preds = %24
  %38 = load i32, i32* %2, align 4
  store i32 %38, i32* %6, align 4
  %39 = load i32, i32* %2, align 4
  %40 = srem i32 %39, 2
  %41 = icmp eq i32 %40, 1
  br i1 %41, label %42, label %45

42:                                               ; preds = %37
  %43 = load i32, i32* %6, align 4
  %44 = add nsw i32 %43, -1
  store i32 %44, i32* %6, align 4
  br label %45

45:                                               ; preds = %42, %37
  store i32 0, i32* %3, align 4
  br label %46

46:                                               ; preds = %68, %45
  %47 = load i32, i32* %3, align 4
  %48 = load i32, i32* %6, align 4
  %49 = sdiv i32 %48, 2
  %50 = icmp sle i32 %47, %49
  br i1 %50, label %51, label %71

51:                                               ; preds = %46
  %52 = load i32, i32* %3, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 %53
  %55 = load i8, i8* %54, align 1
  %56 = sext i8 %55 to i32
  %57 = load i32, i32* %2, align 4
  %58 = sub nsw i32 %57, 1
  %59 = load i32, i32* %3, align 4
  %60 = sub nsw i32 %58, %59
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 %61
  %63 = load i8, i8* %62, align 1
  %64 = sext i8 %63 to i32
  %65 = icmp ne i32 %56, %64
  br i1 %65, label %66, label %67

66:                                               ; preds = %51
  store i32 0, i32* %4, align 4
  br label %67

67:                                               ; preds = %66, %51
  br label %68

68:                                               ; preds = %67
  %69 = load i32, i32* %3, align 4
  %70 = add nsw i32 %69, 1
  store i32 %70, i32* %3, align 4
  br label %46

71:                                               ; preds = %46
  %72 = getelementptr inbounds [64 x i8], [64 x i8]* %5, i64 0, i64 0
  %73 = load i8, i8* %72, align 16
  %74 = sext i8 %73 to i32
  %75 = icmp eq i32 %74, 94
  br i1 %75, label %76, label %81

76:                                               ; preds = %71
  %77 = call i32 @cgc_transmit_all(i32 1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.4, i64 0, i64 0), i64 15)
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %76
  call void @cgc__terminate(i32 0) #3
  unreachable

80:                                               ; preds = %76
  br label %81

81:                                               ; preds = %80, %71
  %82 = load i32, i32* %4, align 4
  store i32 %82, i32* %1, align 4
  br label %83

83:                                               ; preds = %81, %22
  %84 = load i32, i32* %1, align 4
  ret i32 %84
}

declare dso_local i32 @cgc_receive_delim(i32, i8*, i64, i8 signext) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 10.0.0 "}

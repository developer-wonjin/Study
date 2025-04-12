# Gradle Task Tutorial

## 1. Task 기본 구조
```groovy
task taskName {
    doLast {
        println 'Task executed!'
    }
}
```

### 주요 메서드
- `doLast {}`: 태스크의 마지막 단계에서 실행할 작업을 정의.
- `doFirst {}`: 태스크 실행의 첫 번째 단계에서 작업을 정의.
- `dependsOn`: 다른 태스크를 의존성으로 추가해 실행 순서를 정의.

---

## 2. Task 속성
`task`에는 기본적으로 이름, 그룹, 설명 같은 속성을 설정할 수 있습니다.

```groovy
task hello {
    group = 'Example'          // 그룹 이름
    description = 'Prints a greeting message'  // 설명 추가
    doLast {
        println 'Hello, Gradle!'
    }
}
```

### 사용 예
```bash
gradle tasks   # 정의된 모든 태스크 목록 출력
gradle hello   # hello 태스크 실행
```

---

## 3. Task 실행 순서
`dependsOn` 키워드를 사용해 태스크 간 의존성을 설정할 수 있습니다.

```groovy
task taskA {
    doLast {
        println 'Task A executed'
    }
}

task taskB {
    dependsOn taskA
    doLast {
        println 'Task B executed'
    }
}
```

### 실행 결과
```bash
$ gradle taskB
> Task A executed
> Task B executed
```

- **`taskB`는 `taskA`를 먼저 실행한 후 실행됩니다.**

---

## 4. 동적으로 Task 생성

```groovy
5.times { i ->
    task "dynamicTask$i" {
        doLast {
            println "Dynamic Task $i executed"
        }
    }
}
```

### 실행
```bash
gradle dynamicTask0
gradle dynamicTask4
```

---

## 5. Input/Output 속성

Gradle의 태스크는 입력과 출력 속성을 설정해 더 효율적으로 동작할 수 있습니다. 이를 통해 Gradle은 작업을 스킵하거나 결과를 캐싱할 수 있습니다.

```groovy
task copyFiles {
    inputs.files fileTree('src')
    outputs.dir 'dest'

    doLast {
        copy {
            from 'src'
            into 'dest'
        }
        println 'Files copied!'
    }
}
```

---

## 6. 커스텀 Task 클래스

복잡한 태스크를 정의할 때 `CustomTask` 클래스를 작성할 수 있습니다.

### Custom Task 정의
```groovy
class CustomTask extends DefaultTask {
    @TaskAction
    def executeTask() {
        println 'Executing custom task logic!'
    }
}

task customTask(type: CustomTask)
```

### TaskAction
- `@TaskAction` 어노테이션은 실행 가능한 메서드를 정의합니다.

---

## 7. Incremental Task (증분 작업)

Gradle은 작업 입력/출력을 비교해 변경된 경우에만 실행하는 증분 작업을 지원합니다.

```groovy
task incrementalTask {
    inputs.file 'input.txt'
    outputs.file 'output.txt'

    doLast {
        def inputFile = file('input.txt')
        def outputFile = file('output.txt')
        outputFile.text = inputFile.text.toUpperCase()
        println 'Task executed and file transformed.'
    }
}
```

---

## 8. Task 조건부 실행

태스크가 실행될 조건을 설정할 수 있습니다.

### `onlyIf` 조건
```groovy
task conditionalTask {
    onlyIf {
        file('importantFile.txt').exists()
    }
    doLast {
        println 'Conditional Task executed!'
    }
}
```

### `enabled` 속성
```groovy
task optionalTask {
    enabled = false // 비활성화
    doLast {
        println 'This will not run.'
    }
}
```

---

## 9. 태스크 실행 후 작업(Hooks)

Gradle은 태스크 실행 전후에 작업을 추가할 수 있습니다.

### `doFirst`와 `doLast`
```groovy
task exampleTask {
    doFirst {
        println 'This runs before the main task logic.'
    }
    doLast {
        println 'This runs after the main task logic.'
    }
}
```

### `finalizedBy`
태스크가 완료된 후 추가 태스크를 실행합니다.

```groovy
task taskC {
    doLast {
        println 'Task C executed'
    }
}

task taskD {
    doLast {
        println 'Task D executed'
    }
}

taskC.finalizedBy taskD
```

---

## 10. 예제: 복잡한 작업 체인

```groovy
task clean {
    doLast {
        println 'Cleaning up...'
    }
}

task compile {
    dependsOn clean
    doLast {
        println 'Compiling source code...'
    }
}

task build {
    dependsOn compile
    doLast {
        println 'Building project...'
    }
}
```

### 실행 결과
```bash
gradle build
> Cleaning up...
> Compiling source code...
> Building project...
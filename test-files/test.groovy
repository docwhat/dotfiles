class SomeClass {
    SomeClass() {
        this.someField = 10
    }

    static final String DEFAULT = 'default'

    String final aField = 'with flowers'

    def mouse(String name) {
        println("Name: ${name}")
    }
}

String someFunction(String name, Number count) {
    println "${name} says '${count}'"
}

someFunction('Fred', 31415926)

def dictionary = [
fred: true,
gracie: false
]

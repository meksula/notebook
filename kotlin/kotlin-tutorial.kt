
// Można użyć takiego zapisu jak poniżej, żeby z kody Java można było
// wywoływać funkcje tak: Tutorial.foo(), albo ze statycznego importu
// // @file:JvmName("Tutorial")
package tutorial

import java.io.IOException

// // możemy używać idiomów, np. data oznacza, że ta klasa to będzie zwykłe DTO
data class Person(val name: String, val age: Int) {
    
    override fun toString(): String {
        val adult: String = "adult"
        val child: String = "child"
//         Świetne rozwiązanie! IF jako wyrażenie,
//         nie trzeba teraz pisać rozwlekłych ifów, elvis expression etc.
        val result: String = if (amIAdult(this)) adult else child
//         String templates, możemy sobie elegancko osadzać w stringu zmienne,
//         bez walenia plusów
        return "Imię: ${name}\nLat: ${age}\nI'm ${result}"
    }
}

fun main() {
//     Zmienne:
//     var = zmienna
//     val = (value) stała, read-only
	val me: Person = Person("Karol", 27)
    val someChild: Person = Person("Jenny", 13)
    var allPeople: List<Person> = findAllPerson()
	
    var aggregated: ArrayList<Person> = ArrayList(allPeople)
    aggregated.add(me)
    aggregated.add(someChild)
    
    var namedParams: Person = createPerson(name="Jadis")
    aggregated.add(namedParams)
    
    println("This is a Jacksons family presentation:")
	aggregated.forEach({ member -> println("${member.name} is a ${familyMember(member.name)} in this family.") })

	loopExample()
    rangeLoopExample()
}

// Taka funkcja to jest 'top-level-function'
// Można ją wywołać z kodu javy zupełnie jakby to była metoda statyczna
// osadzona w jakiejś klasie
fun amIAdult(person: Person): Boolean {
    return person.age > 18
}

// W kotlinie nie ma 'niskopoziomowych' tablic jak w javie
// Wszystko w bytecode i tak kompiluje się do tablic
fun findAllPerson(): List<Person> {
    var a: Person = Person("Ben", 31)
    var b: Person = Person("Sara", 24)
    return listOf(a, b)
}

// Named parameters
// Kotlin używa tego mechanizmu analogicznie jak python
// Nie musimy przeciążać metod, możemy napisać jedną metodę,
// wraz z wieloma parametrami.
// Jeśli chcemy taką metodę wywołać, po prostu zmieniamy name parameters
// 
@JvmOverloads
fun createPerson(name: String = "no-name", age: Int = 0): Person {
    return Person(name, age)
}

// powyższą funkcję z named parameters możemy wywołać tak:
// createPerson("Jadis")
// ~ nie musimy powielać naszego kodu! #Zeroboilerplate
// Możemy dodać @JvmOverloads jeśli chcemy, żebyśmy w Javie
// mogli wywołać przeciążone metody


// Przykładowe użycia wyrażenia 'when'

fun familyMember(name: String): String {
    return when (name) {
        "Sara" -> "Mother"
        "Ben" -> "Father"
        "Karol" -> "Sara's lover"
        "Jenny" -> "Dother"
        "Jadis" -> "Just born baby"
        else -> "Not a family member"
    }
}


// Pętle 

fun loopExample() {
    val numbers: List<Int> = listOf(1, 2, 3, 4, 5)
    for (num in numbers) {
        println(num)
    }
}

// Iteracja po zakresie - działanie jak w pytonie range()
fun rangeLoopExample() {
    for (num in 1..5) {
        println(num)
    }
}

// while oraz do-while się nie zmieniły konstrukcyjnie

fun untilLoop() {
    for (c in '0' until '9') { print(c) }
}


//  Kotlin nie rozróżnia wyjątków na checked i unchecked
// Aby móc użyć z Javy funkcję kotlina, która zgłasza wyjątek,
// musimy użyć adnotacji: @Throws(IOException::class)
// 
@Throws(IOException::class)
fun exceptionallyCall() {
    throw IOException()
}  




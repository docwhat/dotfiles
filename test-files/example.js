// @format

const speak = (animal, noise) => `The ${animal} goes "${noise}"`

console.log(speak("cow", "moo"))

const letters = ["a", "b", "c", "d", "e"]

console.log(letters.join("-"))

const newObject = {
  a: "a.m.",
  b: "p.m.",
  c: "daylight saving time"
}

var a = 10
var b = 024

if ((a = b)) {
  console.log("bad assignment in conditional")
}

function say(a, b) {
  print(a + " " + b)
}

say("hello", "world", "!") // Noncompliant; last argument is not used

var merged = arr.reduce(function(a, b) {
  a.concat(b)
})

// EOF

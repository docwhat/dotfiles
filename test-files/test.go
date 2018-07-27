package main

import (
	"fmt"

	"math/rand"

	flag "github.com/spf13/pflag"
)

var wordsList = []string{
	"ipsum", "semper", "habeo", "duo", "ut", "vis", "aliquyam", "eu", "splendide", "Ut", "mei", "eteu", "nec", "antiopam", "corpora", "kasd", "pretium", "cetero", "qui", "arcu", "assentior", "ei", "his", "usu", "invidunt", "kasd", "justo", "ne", "eleifend", "per", "ut", "eam", "graeci", "tincidunt", "impedit", "temporibus", "duo", "et", "facilisis", "insolens", "consequat", "cursus", "partiendo", "ullamcorper", "Vulputate", "facilisi", "donec", "aliquam", "labore", "inimicus", "voluptua", "penatibus", "sea", "vel", "amet", "his", "ius", "audire", "in", "mea", "repudiandae", "nullam", "sed", "assentior", "takimata", "eos", "at", "odio", "consequat", "iusto", "imperdiet", "dicunt", "abhorreant", "adipisci", "officiis", "rhoncus", "leo", "dicta", "vitae", "clita", "elementum", "mauris", "definiebas", "uonsetetur", "te", "inimicus", "nec", "mus", "usu", "duo", "aenean", "corrumpit", "aliquyam", "est", "eum",
}

func getRandomWord() string {
	return wordsList[rand.Intn(len(wordsList))]
}

func generateWords(length int) string {
	result := "Lorem "
	for i := 0; i < length-1; i++ {
		result += getRandomWord() + " "
	}
	return result
}

func generateParagraphs(count, length uint, separator string) string {
	result := ""
	realLength := length
	if length == 0 {
		length = 10
	}

	for i := 0; i < count; i++ {
		result += fmt.Sprintf("%s%s", generateWords(realLength), separator)
	}
	return result
}

func main() {
	var paragraphs = flag.IntP("paragraphs", "p", 0, "how many paragraphs to generate")
	var words = flag.IntP("words", "w", 0, "how many words to generate")
	var separator = flag.String("paragraph-separator", "\n\n", "the separator between paragraphs")

	flag.Parse()

	if *paragraphs == 0 && *words == 0 {
		flag.Usage()
	} else if *paragraphs != 0 {
		fmt.Println(generateParagraphs(*paragraphs, *words, *separator))
	} else if *words != 0 {
		fmt.Println(generateWords(*words))
	}
}

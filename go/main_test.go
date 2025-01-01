package main

import (
	"fmt"
	"testing"
)

func TestHoge(t *testing.T) {
	t.Run("hoge", func(t *testing.T) {
		x := 123
		x++
		fmt.Println(x)
	})
	t.Run("piyo", func(t *testing.T) {
		x := 123
		x++
		fmt.Println(x)
	})
}

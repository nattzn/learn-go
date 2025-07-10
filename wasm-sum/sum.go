package main

import (
	"syscall/js"
)

func sum(this js.Value, args []js.Value) interface{} {
	a := args[0].Int()
	b := args[1].Int()
	return a + b
}

func main() {
	js.Global().Set("sum", js.FuncOf(sum))
	select {} // WASMランタイムを止めないため
}

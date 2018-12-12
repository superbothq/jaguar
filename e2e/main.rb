require "jaguar/dsl"
include Jaguar::DSL

did_receive_ctrl_c = false

Signal.trap("INT") {
  puts "
ctrl+c received!"
  did_receive_ctrl_c = true
}

Mouse.move(10,10)
Keyboard.type "hello", :enter, [:ctrl, "c"]


Current time is Wed Feb 03 18:42:35 -0800 2010.
How are you?
# Correr

Run a Command Later

## Requirements

* Vim
* `+clientserver` option

## Author

Tatsuhiro Ujihisa
<http://ujihisa.blogspot.com/>

## The overview of the algorithm

1. Vim does `:Correr rake`
2. Correr runs `rake` asynchronously, with saving the output into a tmp file.
3. Correr opens a new window in the Vim.
4. Correr finishes in the meantime.
5. The process

## TODOs

* `plugin/correr.vim command Correr`: needs better completion like shellcmd+file
* `let vim`: needs to be able to run other than ujihisa's environment
* Being able to give up the current task

## Example

    :Correr ruby example/a.rb

return {
  'preservim/vimux',
  config = function()
    vim.cmd [[
      function! VimuxSlimePython()
        " Split the text from register 'v' into lines.
        let lines = split(@v, "\n")

        " If multiple lines, remove those that are completely whitespace.
        if len(lines) > 1
          let non_blank = []
          for line in lines
            if line =~ '\S'
              call add(non_blank, line)
            endif
          endfor
          let lines = non_blank
        endif

        " If nothing remains, exit.
        if len(lines) == 0
          return
        endif

        " Case 1: Only one line.
        if len(lines) == 1
          let cleaned = substitute(lines[0], '^\s*', '', '')
          let final_code = cleaned . "\n"
          let @v = final_code
          call VimuxRunCommand(final_code, 1)
          return
        endif

        " Multiple-line case.
        let cleaned_lines = []

        " -- Process row1: always no indent.
        let row1 = lines[0]
        let row1_trim = substitute(row1, '^\s*', '', '')
        call add(cleaned_lines, row1_trim)

        " -- Process row2: determine its new indent level.
        let row2 = lines[1]
        let row2_trim = substitute(row2, '^\s*', '', '')
        " If row1 is a header, force row2 to indent level 1 (4 spaces); else 0.
        if row1_trim =~ '^\(def\|for\|while\|if\|elif\|else\|try\|except\|class\)\>'
          let desired_indent = 4
        else
          let desired_indent = 0
        endif

        " Calculate the offset from row2’s original indent.
        let row2_orig_indent = strlen(matchstr(row2, '^\s*'))
        let offset = row2_orig_indent - desired_indent
        if offset < 0
          let offset = 0
        endif

        " Force row2’s new indent.
        let row2_new = repeat(' ', desired_indent) . row2_trim
        call add(cleaned_lines, row2_new)
        let prev_new_indent = desired_indent

        " -- Process remaining rows.
        for i in range(2, len(lines)-1)
          let orig_line = lines[i]
          " Skip lines that are completely whitespace.
          if orig_line =~ '^\s*$'
            continue
          endif
          let line_trim = substitute(orig_line, '^\s*', '', '')
          let orig_indent = strlen(matchstr(orig_line, '^\s*'))
          " Apply the offset computed from row2.
          let new_indent = orig_indent - offset
          if new_indent < 0
            let new_indent = 0
          endif
          " If the indent drops from level 1 (or more) to 0, insert an extra row.
          if prev_new_indent >= 4 && new_indent == 0
            call add(cleaned_lines, "")
          endif
          let new_line = repeat(' ', new_indent) . line_trim
          call add(cleaned_lines, new_line)
          let prev_new_indent = new_indent
        endfor

        let final_code = join(cleaned_lines, "\n") . "\n"
        let @v = final_code
        call VimuxRunCommand(final_code, 1)
      endfunction
    ]]

    -- Visual mode: Yank the visual selection into register v, call the cleaning function,
    -- then send an extra newline.
    vim.keymap.set('v', '<leader><CR>', function()
      vim.cmd 'normal! "vy'
      vim.cmd 'call VimuxSlimePython()'
      vim.cmd "call VimuxRunCommand('', 1)"
    end, { noremap = true, silent = true, desc = 'Send selected text to tmux with extra blank row' })

    -- Normal mode: Yank the current line into register v, call the cleaning function, then move to next line.
    vim.keymap.set('n', '<leader><CR>', function()
      vim.cmd 'normal! "vyy'
      vim.cmd 'call VimuxSlimePython()'
      vim.cmd 'normal! j'
    end, { noremap = true, silent = true, desc = 'Send current line to tmux and jump to next line' })

    -- Whole buffer: Yank the entire buffer into register v and send it.
    vim.keymap.set('n', '<leader><S-CR>', ':%yank v<CR>:call VimuxSlimePython()<CR>', { noremap = true, silent = true, desc = 'Send whole buffer to tmux' })
  end,
}

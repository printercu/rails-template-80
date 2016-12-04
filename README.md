# «80-chars lines» Rails template

Add this to `rails new` command:

```
-m https://raw.githubusercontent.com/printercu/rails-template-80/master/template.rb
```

## Why

If you use linters like rubocop, they usually check for maximum line length.

Fresh-baked rails app contains several files with very long lines
which trigger linter warnings.
Rails team rejects any PRs that going to fix it.

Thanks to app templates, this can be fixed automatically in the new app.

## How

Template just replaces matching lines similar to `patch`,
but ignores any missing lines to replace. So it will work for multiple versions
of Rails.

## Contributing

- Fork, clone, `bundle install`.
- Edit.
- Run `rake` and check rubocop's output.
- _Optionally._ Add `NEW_ARGS='--edge --smth-else'` to `rake` command
  to create rails app with specific args.
- Submit PR.

## License

MIT

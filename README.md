# tmux-project-session

A Zsh plugin for automatic tmux session management.

The plugin automatically creates and attaches to a tmux session based on the current project context. The session name is provided via the `TMUX_PROJECT_SESSION` environment variable, which makes easy to integrate with existing tooling.

---

## How it works

* Plugin looks for the `TMUX_PROJECT_SESSION` environment variable.
* If the variable is not set, the plugin does nothing.
* The plugin checks whether it is already running inside tmux:
  * If yes, it checks if the current session name matches the variable:
    * If it does not match, you get a warning message.
  * If no, it checks if a tmux session with `TMUX_PROJECT_SESSION` name exists:
    * If it exists, it advises you to attaches to it.
    * If it does not exist, it advises you to create new session.

Additionally, you can use `tt` alias to quickly create or attach to the project tmux session.

---

## Configuration

The plugin is configured **only** via the `TMUX_PROJECT_SESSION` environment variable.

In practice, the variable is usually managed by a project-aware tool such as `mise` or `direnv`.

### Using with mise

If you use [mise](https://mise.jdx.dev/) to manage per-project environment variables, add the variable to your `mise.toml` configuration:

```toml
[env]
TMUX_PROJECT_SESSION = "my-project"
```

### Using with direnv

If you use `direnv`, define the variable in your `.env` file:

```sh
TMUX_PROJECT_SESSION=my-project
```

## License

MIT


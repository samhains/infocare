# KindyNow QK Server

## Project Setup

### Install asdf (version manager)

Follow instructions here: https://github.com/asdf-vm/asdf

### Add required asdf plugins

```
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
```

### Install Erlang + Elixir

Run the following command from the root directory of this project

```
asdf install
```

### Install Hex (if not installed already)

```
mix local.hex
```

### Install Phoenix

```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
```

This next command doesn't need to be run, just an FYI as to how this project was initialised

```
mix phoenix.new kindynow_auth_new --app kindy_now_auth --no-brunch --no-html
```

### Install Dependencies

```
mix deps.get
mix deps.compile
```

### Configure Environment Variables

```
cp ./config/dev.exs.example ./config/dev.exs
cp ./config/test.exs.example ./config/test.exs
```

Edit the config in the copied files to suit your environment

### Run the application

```
mix ecto.create
mix phoenix.server
```

To run in a different environment

```
MIX_ENV=test mix phoenix.serevr
MIX_ENV=prod mix phoenix.server
```

### Run the application inside IEx (Interactive Elixir)

```
iex -S mix phoenix.server
```

## Running Tests

```
mix test
```

## Building a release

```
mix release
```

## Running Dialyzer

```
# Only need to run this once
mix dialyzer.plt

# Then run this every time
mix dialyzer
```

## Running Credo

```
mix credo
```

## Running Lint

```
mix dogma
```


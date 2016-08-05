defmodule InfoCare.Jobs do
  use GenServer
  require IEx

  def start_link do
    IO.puts "Jobs::start_link"
    GenServer.start_link(__MODULE__, [], [{:name, __MODULE__}])
  end

  def init do
    IO.puts "Jobs::init"
  end
end


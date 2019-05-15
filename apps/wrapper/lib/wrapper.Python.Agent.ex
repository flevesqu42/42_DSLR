defmodule Wrapper.Python.Agent do

  def new() do
    loop_in_stdin = """
import sys
for line in sys.stdin:
  exec(line)
"""
    cmd = "python3 -c '#{loop_in_stdin}'"
    port_to_python = Port.open({:spawn, cmd}, [:binary])
    {:ok, agent} = Agent.start fn -> Map.new([port: port_to_python]) end
    agent
  end

  def close(agent) do
    agent
          |> Agent.get(&Map.get(&1, :port))
          |> Port.close
    Agent.stop agent, :normal
  end

  def send(agent, command) do
    true = agent
          |> Agent.get(&Map.get(&1, :port))
          |> Port.command("#{command}\n")
  end

end

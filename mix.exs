defmodule Ellix.Mixfile do
  use Mix.Project

  def project do
    [ app: :ellix,
      version: "0.0.1",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:elli, "0.3", git: "git://github.com/knutin/elli.git"}
    ]
  end
end

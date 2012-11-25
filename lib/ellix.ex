defmodule Ellix do
  def start do
    :ok = :application.start(:sasl)
    {:ok, _pid} = :elli.start_link([{:callback, EllixApi}, {:port, 3000}])
    :ok = :application.start(:ellix)
  end
end

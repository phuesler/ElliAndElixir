defmodule EllixApi do
  @behavior :elli_handler
  defrecord ElliRequest, Record.extract(:req, from_lib: "elli/include/elli.hrl")

  def handle(req, _args) do
    request_method = :elli_request.method(req)
    path = :elli_request.path(req)
    :error_logger.error_msg("~p", [req])
    :error_logger.error_msg("~p ~p", [request_method, path])
    # why does this fail?
    'GET' = request_method
    handle(request_method, path, req)
  end

  def handle('GET', [], _req) do
    {:ok, [], <<"Hello Elixir">>}
  end

  def handle('GET', [<<"hello">>, <<"world">>], _req) do
    {:ok, [], <<"Hello World!">>}
  end

  def handle(_,_, _req) do
    {404, [], <<"Not Found">>}
  end


  def handle_event(:request_complete, [_req, _responseCode, _responseHeaders,
                                _responseBody, _timings], _config) do
    :ok
  end

  def handle_event(:request_throw, [req, exception, stack], _config) do
    log_exception(req, exception, stack)
  end

  def handle_event(:request_exit, [_req, _exit, _stack], _config) do
    :ok
  end

  def handle_event(:request_closed, _data, _config) do
    :ok
  end

  def handle_event(:request_error, [req, error, stack], _config) do
    log_exception(req, error, stack)
    :ok
  end

  def handle_event(:request_parse_error, [data], _args) do
    :error_logger.error_msg("request parse error: ~p", [data])
    :ok
  end

  def handle_event(:bad_request, data, _args) do
    :error_logger.error_msg("bad request: ~p", [data])
    :ok
  end

  def handle_event(:client_closed, [_when], _config) do
    :ok
  end

  def handle_event(event, data, args) do
    :error_logger.error_msg("unhandled event: ~p, ~p, ~p", [event, data, args])
    :ok
  end

  def log_exception(req, exception, stack) do
    :error_logger.error_msg("exception: ~p~nstack: ~p~nrequest: ~p~n",
                           [exception, stack, :elli_request.to_proplist(req)])
    :ok
  end
end

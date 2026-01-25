sealed class AsyncStatus<R, F> {
  const AsyncStatus();
}

class AsyncIdle<R, F> extends AsyncStatus<R, F> {
  const AsyncIdle();
}

class AsyncLoading<R, F> extends AsyncStatus<R, F> {
  const AsyncLoading();
}

class AsyncFailure<R, F> extends AsyncStatus<R, F> {
  const AsyncFailure(this.error);
  final R error;
}

class AsyncEffect<R, F> extends AsyncStatus<R, F> {
  const AsyncEffect(this.effect);
  final F effect;
}

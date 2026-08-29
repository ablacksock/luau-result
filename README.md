# Result

A small, typed `Result<T, E>` utility for Luau

Ported from [Rust](https://doc.rust-lang.org/std/result/)

```luau
local Result = require(path.to.Result)
```

## Example

```luau
local result = Result.ok(10)

local doubled = Result.map(result, function(value)
	return value * 2
end)

print(Result.unwrap(doubled)) -- 20
```

## API

**Create**

```luau
Result.ok(value: T): Ok<T>
Result.err(error: E): Err<E>
Result.try(callback: () -> T): Result<T, string>
Result.validate(value: T, predicate: (T) -> boolean, error: E): Result<T, E>
```

**Extract**

```luau
Result.unwrap(result: Result<T, E>): T
Result.unwrap_err(result: Result<T, E>): E
Result.unwrap_or(result: Result<T, E>, fallback: T): T
Result.unwrap_or_else(result: Result<T, E>, callback: (E) -> T): T

Result.expect(result: Result<T, E>, message: string): T
Result.expect_err(result: Result<T, E>, message: string): E
```

**Transform**

```luau
Result.map(result: Result<T, E>, callback: (T) -> U): Result<U, E>
Result.map_err(result: Result<T, E>, callback: (E) -> F): Result<T, F>
Result.map_or(result: Result<T, E>, fallback: U, callback: (T) -> U): U
Result.map_or_else(result: Result<T, E>, err: (E) -> U, ok: (T) -> U): U

Result.filter(result: Result<T, E>, predicate: (T) -> boolean): Result<T, E>
```

**Process**

```luau
Result.chain(result: Result<T, E>, callback: (T) -> Result<U, E>): Result<U, E>
Result.recover(result: Result<T, E>, callback: (E) -> Result<T, F>): Result<T, F>

Result.inspect(result: Result<T, E>, callback: (T) -> ()): Result<T, E>
Result.inspect_err(result: Result<T, E>, callback: (E) -> ()): Result<T, E>

Result.all(results: { Result<T, E> }): Result<{ T }, E>
Result.any(results: { Result<T, E> }): Result<T, { E }>
```

## Types

```luau
Result.Ok<T>
Result.Err<E>
Result.Result<T, E>
```

--!strict

const types = require("./types")
const create = require("./create")

type Ok<T> = types.Ok<T>
type Err<E> = types.Err<E>
type Result<T, E> = types.Result<T, E>

local transform = {}

function transform.map<T, U, E>(
	result: Result<T, E>,
	fn: (T) -> U
): Result<U, E>
	if result.ok == true then
		return create.ok(fn(result.value))
	end

	return result
end

function transform.map_err<T, E, F>(
	result: Result<T, E>,
	fn: (E) -> F
): Result<T, F>
	if result.ok == false then
		return create.err(fn(result.error))
	end

	return result
end

function transform.map_or<T, U, E>(
	result: Result<T, E>,
	default: U,
	fn: (T) -> U
): U
	if result.ok == true then
		return fn(result.value)
	end

	return default
end

function transform.map_or_else<T, U, E>(
	result: Result<T, E>,
	default: (E) -> U,
	fn: (T) -> U
): U
	if result.ok == true then
		return fn(result.value)
	end

	return default(result.error)
end

function transform.filter<T, E>(
	result: Result<T, E>,
	predicate: (T) -> boolean,
	error_value: E
): Result<T, E>
	if result.ok == false then
		return result
	end

	if predicate(result.value) then
		return result
	end

	return create.err(error_value)
end

return transform

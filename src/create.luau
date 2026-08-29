--!strict

const types = require("./types")

type Ok<T> = types.Ok<T>
type Err<E> = types.Err<E>
type Result<T, E> = types.Result<T, E>

local create = {}

function create.ok<T>(value: T): Ok<T>
	return {
		ok = true,
		value = value,
	}
end

function create.err<E>(error: E): Err<E>
	return {
		ok = false,
		error = error,
	}
end

function create.try<T>(fn: () -> T): Result<T, unknown>
	local success, value = pcall(fn)

	if success then
		return create.ok(value)
	end

	return create.err(value)
end

function create.validate<T, E>(value: T, predicate: (T) -> boolean, error: E): Result<T, E>
	if predicate(value) then
		return create.ok(value)
	end

	return create.err(error)
end

return create

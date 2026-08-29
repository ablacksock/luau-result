--!strict

const types = require("./types")
const create = require("./create")

type Ok<T> = types.Ok<T>
type Err<E> = types.Err<E>
type Result<T, E> = types.Result<T, E>

local process = {}

function process.chain<T, U, E>(
	result: Result<T, E>,
	fn: (T) -> Result<U, E>
): Result<U, E>
	if result.ok == true then
		return fn(result.value)
	end

	return result
end

function process.recover<T, E, F>(
	result: Result<T, E>,
	fn: (E) -> Result<T, F>
): Result<T, F>
	if result.ok == false then
		return fn(result.error)
	end

	return result
end

function process.inspect<T, E>(
	result: Result<T, E>,
	fn: (T) -> ()
): Result<T, E>
	if result.ok == true then
		fn(result.value)
	end

	return result
end

function process.inspect_err<T, E>(
	result: Result<T, E>,
	fn: (E) -> ()
): Result<T, E>
	if result.ok == false then
		fn(result.error)
	end

	return result
end

function process.all<T, E>(results: { Result<T, E> }): Result<{ T }, E>
	local values = {}

	for _, result in results do
		if result.ok == false then
			return result
		end

		table.insert(values, result.value)
	end

	return create.ok(values)
end

function process.any<T, E>(results: { Result<T, E> }): Result<T, { E }>
	local errors = {}

	for _, result in results do
		if result.ok == true then
			return result
		end

		table.insert(errors, result.error)
	end

	return create.err(errors)
end

return process

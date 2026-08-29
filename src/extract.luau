--!strict

const types = require("./types")

type Ok<T> = types.Ok<T>
type Err<E> = types.Err<E>
type Result<T, E> = types.Result<T, E>

local extract = {}

function extract.unwrap<T, E>(result: Result<T, E>): T
	if result.ok == false then
		error(result.error, 2)
	end

	return result.value
end

function extract.unwrap_err<T, E>(result: Result<T, E>): E
	if result.ok == true then
		error(`unwrap_err failed: {result.value}`, 2)
	end

	return result.error
end

function extract.unwrap_or<T, E>(result: Result<T, E>, default: T): T
	if result.ok == false then
		return default
	end

	return result.value
end

function extract.unwrap_or_else<T, E>(result: Result<T, E>, fn: (E) -> T): T
	if result.ok == true then
		return result.value
	end

	return fn(result.error)
end

function extract.expect<T, E>(result: Result<T, E>, message: string): T
	if result.ok == false then
		error(`{message}: {result.error}`, 2)
	end

	return result.value
end

function extract.expect_err<T, E>(result: Result<T, E>, message: string): E
	if result.ok == true then
		error(`{message}: {result.value}`, 2)
	end

	return result.error
end

return extract

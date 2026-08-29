--!strict

const types = require("@self/types")
const create = require("@self/create")
const extract = require("@self/extract")
const process = require("@self/process")
const transform = require("@self/transform")

export type Ok<T> = types.Ok<T>
export type Err<E> = types.Err<E>
export type Result<T, E> = types.Result<T, E>

return {
	ok = create.ok,
	err = create.err,
	try = create.try,
	validate = create.validate,

	unwrap = extract.unwrap,
	unwrap_err = extract.unwrap_err,
	unwrap_or = extract.unwrap_or,
	unwrap_or_else = extract.unwrap_or_else,
	expect = extract.expect,
	expect_err = extract.expect_err,

	map = transform.map,
	map_err = transform.map_err,
	map_or = transform.map_or,
	map_or_else = transform.map_or_else,
	filter = transform.filter,

	chain = process.chain,
	recover = process.recover,
	inspect = process.inspect,
	inspect_err = process.inspect_err,

	all = process.all,
	any = process.any,
}

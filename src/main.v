module main

import x.json2
import json
import os

fn main() {
	// Switch between use_json and use_json2 to see the result
	use_json()!
	// use_json2()!
}

fn use_json() ! {
	content := os.read_file('./src/Devices.SerialCommunication.json')!
	out := json.decode(Declaration, content)!
	println(out)
}

fn use_json2() ! {
	content := os.read_file('./src/Devices.SerialCommunication.json')!
	out := json2.decode[Declaration](content)!
	println(out)
}

struct Declaration {
	constants       []Constant @[json: Constants]
	types           []Type     @[json: Types]
	functions       []Function @[json: Functions]
	unicode_aliases []string   @[json: UnicodeAliases]
}

struct Constant {
	name  string        @[json: Name]
	@type struct {
		kind        string   @[json: Kind]
		name        string   @[json: Name]
		target_kind ?string  @[json: TargetKind]
		api         ?string  @[json: Api]
		parents     []string @[json: Parents]
	} @[json: Type]

	valuetype string   @[json: ValueType]
	value     int      @[json: Value]
	attrs     []string @[json: Attrs]
}

struct Type {
	name          string          @[json: Name]
	architectures []string        @[json: Architectures]
	platform      ?string         @[json: Platform]
	kind          string          @[json: Kind]
	flags         bool            @[json: Flags]
	scoped        bool            @[json: Scoped]
	values        []struct {
		name  string @[json: Name]
		value int    @[json: Value]
	} @[json: Values]

	integer_base ?string @[json: IntegerBase]
}

struct Function {
	name           string        @[json: Name]
	set_last_error bool          @[json: SetLastError]
	dll_import     string        @[json: DllImport]
	return_type    struct {
		kind        string    @[json: Kind]
		name        string    @[json: Name]
		target_kind ?string   @[json: TargetKind]
		api         ?string   @[json: Api]
		parents     ?[]string @[json: Parents]
	} @[json: ReturnType]

	return_attrs  []string        @[json: ReturnAttrs]
	architectures []string        @[json: Architectures]
	platform      ?string         @[json: Platform]
	attrs         []string        @[json: Attrs]
	params        []struct {
		name  string        @[json: Name]
		@type struct {
			kind        string   @[json: Kind]
			name        string   @[json: Name]
			target_kind string   @[json: TargetKind]
			api         string   @[json: Api]
			parents     []string @[json: Parents]
		} @[json: Type]

		attrs []string @[json: Attrs]
	} @[json: Params]
}

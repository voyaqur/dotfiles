; Place this file at:
;   ~/.config/nvim/after/queries/rust/highlights.scm
;
; Neovim loads `after/queries/rust/highlights.scm` IN ADDITION TO
; nvim-treesitter's stock query — it does not replace it. Captures
; defined here that fire on the same node as a stock capture win,
; because later-loaded queries take priority at equal @-priority.
;
; This patch adds two distinctions the stock rust query does not
; make on its own:
;
;   1. A genuine @type.definition for struct/enum/union/trait/type
;      *declaration* names, separate from every other reference to
;      that type (stock query uses plain @type for both).
;
;   2. Splits #[derive(...)] / #[cfg(...)] / #[allow(...)] etc.
;      attribute names off of @function.macro (which stock rust
;      shares with println!/vec!) into a dedicated @attribute.macro
;      capture, so real macros and quiet annotations can be styled
;      differently. Deliberately NOT @attribute or @attribute.builtin —
;      stock rust already uses those two for lifetimes, and reusing
;      either here would make #[derive(...)] render the same color
;      as a lifetime, which defeats the point.

; ----- 1. Real declaration-vs-usage for type names -----
(struct_item name: (type_identifier) @type.definition)
(enum_item name: (type_identifier) @type.definition)
(union_item name: (type_identifier) @type.definition)
(trait_item name: (type_identifier) @type.definition)
(type_item name: (type_identifier) @type.definition)

; ----- 2. Split #[attributes] off of @function.macro -----
(attribute_item
  (attribute
    (identifier) @attribute.macro))
(inner_attribute_item
  (attribute
    (identifier) @attribute.macro))
(attribute
  (scoped_identifier
    (identifier) @attribute.macro .))

; ----- 3. Unify attribute delimiters -----
; Stock rust sends the outer "#" to @punctuation.special but leaves
; "[" "]" "!" as plain @punctuation.bracket — the same group used for
; every other bracket in the file (function calls, tuples, arrays...).
; That's why #[derive(...)] can look like it's made of two unrelated
; bracket colors instead of reading as one attribute shell. This
; reroutes all of an attribute's own delimiters onto @punctuation.special
; so "#", "[", "]" (and "!" on inner attributes) match the attribute
; name's color as a single visual unit, without touching brackets
; anywhere else in the file.
(attribute_item
  [ "#" "[" "]" ] @punctuation.special)
(inner_attribute_item
  [ "#" "!" "[" "]" ] @punctuation.special)

; ----- 4. Split derive(...)'s trait names out from the shell -----
; #[derive(Debug, Clone)] — "derive" and its own parens stay the
; attribute-shell color from sections 2/3 above; Debug/Clone/etc.
; get pulled into @constructor instead, which stock rust never uses
; for anything (repurposed here on purpose, so it's safe to claim).
; Only reaches simple identifier lists — a qualified path like
; #[derive(serde::Serialize)] falls back to normal @module/@type
; handling for the qualified parts, which is a reasonable fallback.
(attribute
  (identifier) @_derive_name
  (#eq? @_derive_name "derive")
  arguments: (token_tree
    [ "(" ")" ] @punctuation.special))

(attribute
  (identifier) @_derive_name
  (#eq? @_derive_name "derive")
  arguments: (token_tree
    (identifier) @constructor))

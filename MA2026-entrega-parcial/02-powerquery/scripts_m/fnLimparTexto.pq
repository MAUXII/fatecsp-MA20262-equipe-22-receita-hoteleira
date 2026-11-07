// fnLimparTexto
(v as any) as nullable text => if v = null then null else Text.Combine(List.Select(Text.Split(Text.Trim(Text.From(v)), " "), each _ <> ""), " ")
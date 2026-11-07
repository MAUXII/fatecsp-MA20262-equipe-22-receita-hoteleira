// fnValorOficial
(v as nullable text, lista as list) as nullable text => if v = null then null else List.First(List.Select(lista, each Text.Upper(_)=Text.Upper(v)),v)
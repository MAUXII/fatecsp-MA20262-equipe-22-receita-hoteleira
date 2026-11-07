// fnData
(v as any) as nullable date => try
if v = null then null else if v is date then v else if v is datetime or v is number then Date.From(v)
else let p=Text.Split(Text.Replace(Text.Trim(Text.From(v)),"/","-"),"-"), a=Number.From(p{0}), b=Number.From(p{1}), c=Number.From(p{2})
in if Text.Length(p{0})=4 then #date(a,b,c) else #date(c,b,a)
otherwise null
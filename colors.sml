fun parse file =
    let
	(* A function to read an integer from specified input. *)
        fun readInt input = 
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
	(* Open input file. *)
    	val inStream = TextIO.openIn file
        (* Read an integer (megethos kordelas) and consume newline. *)
	val n = readInt inStream
          (* Read an integer (arithmso pithanwn xromatwn) and consume newline. *)
	val t = readInt inStream
	val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
	fun readInts 0 acc = rev acc 
	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n, t , readInts n [])
    end
(* i parse sinartisi einai profanos apo to softlab apo ton skeleto tis proigoumenis pou dinetai stin istoselida*)

structure Key=
 struct
  type ord_key=int
  val compare=Int.compare
 end

(*epistrfei mikrotero airthmo*)
fun min x y = if x>y then y else x;

structure mymap = BinaryMapFn ( Key  );

(* oi domes struct key kai to ordered map  gia to pos  dilothoune kai pos xrisimopouountai https://stackoverflow.com/questions/12199545/using-ord-map-as-a-hash-table-in-sml-nj *)
(* http://www.smlnj.org/doc/smlnj-lib/Manual/ord-map.html#section:0 *)


(* http://sml-family.org/Basis/option.html me auto to link kai me vasi to apo panw eftiaksa to poses fores exw vrei ena xroma *)
(* sliding window technique- xrisimopoiithike poli to google  kai sites opws github  prokeimenou na katanoithei*) 

fun smallest_sub(n,t,list1,list2,front,tail,minimum,k,cmap)=
let

 fun increase(n,t,list1,list2,front,tail,minimum,k,cmap)=
  let 
   val number= hd list1
   val elem=mymap.find(cmap,number)
   val per=getOpt(elem,0)+1
   
   fun decrease(n,t,list1,list2,front,tail,minimum,k,cmap)=
    let 
     val number=hd list2
     val elem=mymap.find(cmap,number) 
     val per=getOpt(elem,0)-1 
     val howmany=getOpt(elem,0) 
    in
    if (howmany>1) then decrease (n,t,list1, tl list2,front,tail+1,min minimum (front-tail),k,mymap.insert(cmap,number,per))      
    else (n,t,list1,list2,front,tail,min minimum (front-tail),k,cmap)
    end


  in if k= t
         then decrease (n,t, tl list1, list2, front + 1 ,tail,minimum, k,mymap.insert(cmap,number,per))
    else if elem =NONE 
             then (if k=t-1
                  then decrease (n,t, tl list1, list2, front + 1 ,tail,minimum, k+1,mymap.insert(cmap,number,per))
                   else increase (n,t, tl list1, list2, front + 1 ,tail,minimum, k+1,mymap.insert(cmap,number,per)))
     else if ((tl list1)=[]) 
              then (n,t, list1, list2, front + 1 ,tail,0, k,cmap)
    else increase (n,t, tl list1, list2, front + 1 ,tail,minimum,k,mymap.insert(cmap,number,per))
end 

 
in
  if n=front 
   then minimum
  else
  smallest_sub(increase(n,t,list1,list2,front,tail,minimum,k,cmap))
end



fun colors file = 
        let
           val (n, t, Flist) = parse file    
           val cmap = mymap.empty
        in
          print (Int.toString( smallest_sub( n, t, Flist, Flist , 0, 0, n, 0, cmap  ) )^"\n")
        end



















  

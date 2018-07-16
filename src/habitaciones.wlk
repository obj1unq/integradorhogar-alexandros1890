//TODO: Nota: 5 cinco 

//test: pasa valores iniciales. Solo los test del punto 1 andan
//1.1 MB- (usa alguna variable innecesaria)
//1.2 MB- (método innecesario)
//2.1 MB
//2.2 MB
//2.3 R: Está bien lo de excepciones, pero no cumple el requerimiento consistentemente, ya que no modifica los ocupantes de las habitaciones
//3.1 MB-
//3.2 M
//3.3 y 3.4 No lo hace


class Casa{
	var property habitaciones=#{}
	
	method habitacionesOcupadas(){
		return habitaciones.filter({e=>not e.estaVacia()})
	}
	method ocupantesDeLaCasa(){
		//TODO: No, debe ser un map sobre las habitacionesOcupadas
		habitaciones.filter({e=>e.ocupantes()})
	}
//	method responsables(){
//		return self.ocupantesDeLaCasa().filter({e=>e.edad()})
//	}
//	method confortPromedio(){
//		return self.ocupantesDeLaCasa()
//	}
}

class Habitacion{
	//TODO: Variable innecesaria, siempre es 10!
	var property confort=10
	var property ocupantes=#{}
	
	method aporteConfort(unaPersona){
	return confort
	
	}
	method estaVacia(){
		//TODO: usar isEmpty
		return ocupantes.size()==0
	}
	method puedeEntrar(unaPersona){
		return self.estaVacia()
	}
	method cantidadDeOcupantes(){
		ocupantes.size()
	}
}

//TODO: Esta clase es innecesaria porque no aporta comportamiento
class General inherits Habitacion{
	
}

class Cocina inherits Habitacion{
	var property m2
	
	override method aporteConfort(unaPersona){
		return super(unaPersona)+
		if(unaPersona.buenCocinero()){self.plusCocina()}else{0}
	}
	
	method plusCocina(){
		return m2*(extraCocina.porcentaje() / 100)
	}
	override method puedeEntrar(unaPersona){
		return super(unaPersona)or 
			  not unaPersona.buenCocinero()or
			   self.noHayBuenCocinero()
			  
}
	method noHayBuenCocinero(){
		return not ocupantes.any({e=>e.buenCocinero()})
	}
	
	
}
class Banio inherits Habitacion{
	
	override method aporteConfort(unaPersona){
		return super(unaPersona)+
		if(unaPersona.esMenor()){2}else{4}
	}
	
	override method puedeEntrar(unaPersona){
		return super(unaPersona)or 
			   ocupantes.any({e=>e.esMenor()})
	}
}
class Dormitorio inherits Habitacion{
	var property duenios
	
	method cantidadDeDuenios(){
		return duenios.size()
	}
	method estanLosDuenios(){
		//TODO: Usar mejor los métodos de colecciones, sin comparar con tamaños:
		///return duenios.all({duenio=>self.estaEnLaHabitacion(duenio))
		return duenios.intersection(ocupantes).size()==self.cantidadDeDuenios()
	}
	
	override method aporteConfort(unaPersona){
		return super(unaPersona)+
		if(unaPersona.esDuenio(self)){
			10/self.cantidadDeDuenios()
		}else{0}
	} 
	override method puedeEntrar(unaPersona){
		return super(unaPersona)or 
			   unaPersona.esDuenio(self) or
			   self.estanLosDuenios()
	}
	//TODO: esté método conviene que esté en la superclase, ya que el concepto de "ocuapantes"
	//es algo que está en la superclase
	method estaEnLaHabitacion(unaPersona){
		ocupantes.contains(unaPersona)
	}
}

class Persona{
	var property duenioDe
	var property edad
	var property buenCocinero // true o false
	var property estaEn
		
	method esMenor(){
		return edad<5
	} 
	method esDuenio(unaHabitacion){
		return duenioDe.contains(unaHabitacion)
	}
	method esUnicoDuenio(unaHabitacion){
		return unaHabitacion.cantidadDeDuenios()==1
	}
	method adueniarHabitacion(unaHabitacion){
		duenioDe.add(unaHabitacion)
	}
	method aprenderCocina(){
		buenCocinero=true
	}
	method entrarA(unaHabitacion){
		if(unaHabitacion.puedeEntrar(self)){
		estaEn=unaHabitacion
		//TODO: Falta modificar la listas de ocupantes de la habitacion, tanto 
		//de la habitación que sale como de la que entra
		}else{
		self.error("No puede entrar")	
	}
	
}
}
object extraCocina{
	var property porcentaje = 10
	//TODO: si es una property este método está de más, porque ya tiene un mensaje porcentaje(valor) que hace lo mismo 
	method cambiarPorcentaje(unPorcentaje){
		porcentaje=unPorcentaje
	}
}
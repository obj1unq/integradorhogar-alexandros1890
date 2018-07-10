class Casa{
	var property habitaciones=#{}
	
	method habitacionesOcupadas(){
		return habitaciones.filter({e=>not e.estaVacia()})
	}
	method ocupantesDeLaCasa(){
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
	var property confort=10
	var property ocupantes=#{}
	
	method aporteConfort(unaPersona){
	return confort
	
	}
	method estaVacia(){
		return ocupantes.size()==0
	}
	method puedeEntrar(unaPersona){
		return self.estaVacia()
	}
	method cantidadDeOcupantes(){
		ocupantes.size()
	}
}

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
		}else{
		self.error("No puede entrar")	
	}
	
}
}
object extraCocina{
	var property porcentaje = 10 
	method cambiarPorcentaje(unPorcentaje){
		porcentaje=unPorcentaje
	}
}
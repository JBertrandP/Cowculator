function handleClick(FarmName,FarmID) {
    window.location.href = `/mycattle?ranchName=${FarmName}&ranchId=${FarmID}` /*Aqui poner la ruta*/
    }


window.addEventListener('DOMContentLoaded')



async function updateContadorRancho() {

    totalCows = document.getElementById('contadorGlobal').innerText
    totalSick = document.getElementById('contadorSick').innerText
  
    
    let contadores = {
      totalCows : totalCows,
      totalSick : totalSick
    }
  
    console.log(contadores)
  
  
    let promesa = await fetch('/update_ranch_contador',{
  
      method : 'POST',
      headers : {
        'Content-Type': 'application/json'
      },
      body : JSON.stringify(contadores)
  
    })
  
    let respuesta = await promesa.json
  
    console.log(respuesta)
    
  }
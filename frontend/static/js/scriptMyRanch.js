function handleClick(FarmName,FarmID) {
    window.location.href = `/mycattle?ranchName=${FarmName}&ranchId=${FarmID}` /*Aqui poner la ruta*/
    }


window.addEventListener('popstate',updateContadorRancho)

async function updateContadorRancho() {

    
    console.log('Hola papu Jalo el popstate')
    let promesa = await fetch('/get_ranch_contador')

    let contadores = await promesa.json()
    console.log(contadores)


    for (ranch of contadores){
        console.log(ranch.FarmID)

        document.getElementById(`${ranch.FarmID}`).innerText = ranch.TotalCows
        document.getElementById(`${ranch.FarmID+1}`).innerText = ranch.TotalSickCows


    }



    
  }

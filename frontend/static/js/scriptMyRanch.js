function handleClick(FarmName,FarmID) {
    window.location.href = `/mycattle?ranchName=${FarmName}&ranchId=${FarmID}` /*Aqui poner la ruta*/
}

/*
function newEntry(page){
    history.pushState({ page: page }, '', '');
}



window.addEventListener('popstate', (event) => {
    if (event.state) {
        console.log(`Back/forward to: ${event.state.page}`);
        updateContadorRancho(); // Update content based on the state
    } else {
        console.log('No state found (possibly initial page)');
    }
});


*/

//window.addEventListener('popstate',updateContadorRancho)





window.addEventListener('beforeunload',updateContadorRancho)

async function updateContadorRancho() {
    console.log('Update Ranch Total')
    let promesa = await fetch('/get_ranch_contador')

    let contadores = await promesa.json()
    console.log(contadores)


    for (ranch of contadores){
        console.log(ranch.TotalCows)

        document.getElementById(`${ranch.FarmID}`).innerText = ranch.TotalCows
        document.getElementById(`${ranch.FarmID+1}`).innerText = ranch.TotalSickCows


    }



    
  }

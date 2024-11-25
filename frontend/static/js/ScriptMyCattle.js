

async function addCow() {

    const inputData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };

  
    try{
  
    let promesa = await fetch('/add_cow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(inputData)
    })

    let cow_data = await promesa.json()
    

    const cowDisplay = document.getElementById('addCowDisplay')
   



    breed = inputData.breed

    updateContador(breed)
    getRecentlyAddedCows()
    
    //cowDisplay.innerHTML += newCowDisplay
    
    }
    catch(error){
      console.log(error)
    }
    
}


async function updateCow() {


  //nota para todas las funciones
  //limpiar formularios y mostradores cada vez que se manda la solicitud

  let cowId = {
    cowId : document.getElementById('updateCowId').value
  }
 

  try{
  let promesa = await fetch( '/search_cow' ,{

    method : 'POST',
    headers : {
      'Content-Type' : 'application/json'
    },
    body: JSON.stringify(cowId)
  })

  let cowInfo = await promesa.json()

  
  if(cowInfo){
  //formulario de transferencia
    
  console.log(cowInfo) 
  

  display = document.getElementById('updateCowContainer')
  
  console.log(display)
  newDisplay = ` 
    
              <form id = "cow_form">
                    <h2>Update Cow</h2>
                    <input type="text" placeholder="${cowInfo[0].CowName}" id="updateName">
                    <input type="number" placeholder = "${cowInfo[0].Age}"  id = "updateAge">
                    <select id="updateBreed" >
                        <option value="" disabled selected>Select Breed</option>
                        <option value="Angus" >Angus</option>
                        <option value="Brangus">Brangus</option>
                        <option value="Charolais">Charolais</option>
                        <option value="Hereford">Hereford</option>
                        <option value="Salers Limousin">Salers Limousin</option>
                    </select>
                    <input type="number" placeholder = "${cowInfo[0].Weight}" id="updateWeight">

                        <button type="button" onclick="dbUpdateCow(${cowInfo[0].CowID})">Add Cow</button>

                </form>
     
    `
   
      display.innerHTML = newDisplay


      document.getElementById('updateName').value = cowInfo[0].CowName
      document.getElementById('updateAge').value = cowInfo[0].Age
      document.getElementById('updateWeight').value = cowInfo[0].Weight
      document.getElementById('updateBreed').value = cowInfo[0].Breed
      

  }
  else{
    document.getElementById('showResult').innerHTML = '<h2>Invalid ID</h2>'
    return undefined
  }


}
catch(error){
  console.log(error)
}


}



async function dbUpdateCow(cowId) {

  let cowInfo = {
    cowId :cowId,
    name : document.getElementById('updateName').value,
    age : document.getElementById('updateAge').value,
    breed : document.getElementById('updateBreed').value,
    weight : document.getElementById('updateWeight').value

  }

  console.log(cowInfo)
  
  try {

    let promesa = await fetch('/update_cow',{
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(cowInfo)
    })
    
    let response = promesa.json()

    display = document.getElementById('updateCowContainer')

    newDisplay = ` 

                    <h2>Actualizada con exito!</h2>
                
    `
    display.innerHTML = newDisplay  


    getRecentlyAddedCows()


    
  } catch (error) {
    
  }


}



async function updateContador(breed) {

  let breeds = {'Angus': 'contadorAngus','Brangus': "contadorBrangus"   ,'Charolais': "contadorCharolais" ,'Hereford': "contadorHereford" ,'Salers Limousin': "contadorSalers"}
  
  let contadorGlobal = document.getElementById("contadorGlobal")
  let contadorInt = parseInt(contadorGlobal.innerText)

  contadorInt += 1

  //for...in itera los indices
  //for...of itera los valores

  
  for( let key in breeds){

    if(breed == key){
      
      let contadorLocal = document.getElementById(`${breeds[key]}`)
      console.log(contadorLocal)
      let contadorLocalInt = parseInt(contadorLocal.innerText)

      contadorLocalInt += 1
      contadorLocal.innerText = contadorLocalInt

    }
  }
  contadorGlobal.innerText = contadorInt  
}





//funcion adaptada
//input: De donde consigue la informacion de busqueda
//Output: Donde se muestra el re


async function searchCow(input,output){
  let cowId = {
    cowId : document.getElementById(input).value
  }
 

  try{
  let promesa = await fetch( '/search_cow' ,{

    method : 'POST',
    headers : {
      'Content-Type' : 'application/json'
    },
    body: JSON.stringify(cowId)
  })

  let cowInfo = await promesa.json()

  
  if(cowInfo){
  //checar si returnea vacio
  displaySearchedCow(cowInfo,output)

  return cowInfo
  }
  else{
    document.getElementById(output).innerHTML = '<h2>Invalid ID</h2>'
    return undefined
  }


}
catch(error){
  console.log(error)
}
}

async function displaySearchedCow(cowInfo,output){

  let showSearch = document.getElementById(output)
  
  let showCow = 
    `   <div class="search-cow">
            <h2>${cowInfo[0].CowID}</h2>
            <p>ID: ${cowInfo[0].CowID}</p>
            <p>Name: ${cowInfo[0].CowName}</p>
            <p>Breed: ${cowInfo[0].Breed}</p>
            <p>Age: ${cowInfo[0].Age}</p>
            <p>Weight: ${cowInfo[0].Weight}</p>
            <p>Date Added: ${cowInfo[0].Date}</p> 
        </div> `;


  showSearch.innerHTML = showCow

}

async function getRanchs(){


  try{

    let promesa = await fetch('/get_ranchs_data',{
      
      method : 'GET',
      headers :{
        'Content-Type' : 'application/json'
      }

    })

    const ranchData = await promesa.json()
    

    return ranchData

  }
  catch(error){
    console.log(error)
  }

}

async function getActualRanchId() {

  let url = window.location.href

  let urlObj = new URL(url)

  id = (urlObj.searchParams).get('ranchId')

  return id

}

async function transferCow(){

  try{
  
  let cowData = await searchCow('cowTransferId','showAvailableRanches')
  

  if (cowData){
    
    let ranchData = await getRanchs()
    let displayRanch = document.getElementById('showAvailableRanches')

    
    //meter un loop que concatene a la info
    // que no concatene tu rancho actual 

    let actualRanchId = await getActualRanchId()

    for(const ranch of ranchData){

      
      if(ranch.FarmID != actualRanchId){

        // en el onclick agregar a que rancho se va a mandar la vaca
        

        //intetar cambiar por addEventListener
        //insertar datos de vaca uno por un 
      let ranchInfo = `
        <div class="button-container">

           <div class="ImgBtn" onclick="moveCow(${cowData[0].Age},'${cowData[0].Breed}',${cowData[0].CowID},'${cowData[0].CowName}',${cowData[0].FarmID},${cowData[0].Weight},${ranch.FarmID})">
                        <h1 >${ranch.FarmName}</h1>
                        <img src="data:image/jpeg;base64,${ranch.FarmImage} "  />  
                        <p>Location: ${ranch.Location}</p>                         
                    </div>
        </div>
      
      
      
      `;

      displayRanch.innerHTML += ranchInfo
  
      }
    }



    //mover a la vaca 



  }

  }
  catch(error){
    console.log(error)
  }
}



async function moveCow(age,breed,cowId,cowName,farmId,weight,ranchId) {

  let cowData = {

    Age: age,
    Breed: breed,
    CowID: cowId,
    CowName: cowName,
    FarmID: farmId,
    Weight: weight,
    Destination : ranchId

  }
  


  let promesa = await fetch('/transfer_cow',{

    method : 'POST',
    headers : {
      'Content-Type': 'application/json'
    },
    body : JSON.stringify(cowData)

  })

  let response = promesa.status

  getRecentlyAddedCows()
  
}


document.addEventListener('DOMContentLoaded', () => {
  getRecentlyAddedCows()
});

//intentar mover el index por uno 

async function getRecentlyAddedCows() {
try{

let promesa = await fetch('/recently_added')
let cowData = await promesa.json()

renderAddedCows(cowData)

}catch(exception){
  console.log(exception)
}
}


async function renderAddedCows(cowData){


let display = document.getElementById('showRecentCows')
let tempDisplay = ""
let fechaXD ='fechaXD'
                                                      //id,name,age,breed,weight,date
for(let cowInfo of cowData){
  let newDisplay = `
          <div class="search-cow" onclick="showCowInfo(${cowInfo.CowID},'${cowInfo.CowName}',${cowInfo.Age},'${cowInfo.Breed}',${cowInfo.Weight},'${fechaXD}'), displayContent('content6')">
            <h2>${cowInfo.CowName}</h2>
            <p>ID: ${cowInfo.CowID}</p>
            <p>Name: ${cowInfo.CowName}</p>
            <p>Breed: ${cowInfo.Breed}</p>
            
        </div> `;

    tempDisplay += newDisplay
}

display.innerHTML = tempDisplay

}


function showCowInfo(id,name,age,breed,weight,date){




document.getElementById('selectedCowId').innerText= id
document.getElementById('selectedCowName').innerText = name
document.getElementById('selectedCowAge').innerText = age
document.getElementById('selectedCowBreed').innerText = breed
document.getElementById('selectedCowWeight').innerText = weight
document.getElementById('selectedCowDate').innerText = date




}


async function deleteCow() {

  try {
    
  
    let cowId = {

      cowId : document.getElementById('deleteCowId').value
    }

    let promesaSearch = await fetch( '/search_cow' ,{

      method : 'POST',
      headers : {
        'Content-Type' : 'application/json'
      },
      body: JSON.stringify(cowId)
    })
  
    let cowInfo = await promesaSearch.json()
  
    
    if(cowInfo){

      let showSearch = document.getElementById('delCowDisiplay')
  
      let showCow = 
        `   <div class="deleteCowDisplay">
                <h2>${cowInfo[0].CowID}</h2>
                <p>ID: ${cowInfo[0].CowID}</p>
                <p>Name: ${cowInfo[0].CowName}</p>
                <p>Breed: ${cowInfo[0].Breed}</p>
                <p>Age: ${cowInfo[0].Age}</p>
                <p>Weight: ${cowInfo[0].Weight}</p>
                <p>Date Added: ${cowInfo[0].Date}</p> 
            </div> 
            
            <h2>¿Estas seguro que quieres eliminar a ${cowInfo[0].CowID}</h2>

            <button type="button" onclick="killCow()"> Yes</button>
            <button type="button" onclick="displayContent('content5')"> No</button>



            
            `;

            
    
    
      showSearch.innerHTML = showCow


      
  
    }
    else{
      document.getElementById('delCowDisiplay').innerHTML = '<h2>Invalid ID</h2>'
      return undefined
    }


  } catch (error) {
    console.log(error)
    
  }
  
}


async function killCow(cowId) {

  let cowInfo = {

    cowId : document.getElementById('deleteCowId').value
  }

  let promesa =  await fetch('/delete_cow',{

    method : 'POST',
    headers : {
      'Content-Type': 'application/json'
    },
    body : JSON.stringify(cowInfo)

  })

  let response = await promesa.json



  document.getElementById('delCowDisplay').innerHTML = "<h2>Vaca eliminada con exito</h2>"

  getRecentlyAddedCows()
  
}

/*

function add_cow() {
   
    const cowData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };
  
    fetch('/add_cow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(cowData)
    })
    .then(response => response.json())
    .then(data => {
      
        const cowDisplay = document.getElementById("cowDisplay");

        
        const newCowHTML = `
          
        <button class="cow-info-button">
        <div class="cow-info">
            <h2>Added Cow:</h2>
            <p>ID: ${data.id}</p>
            <p>Name: ${data.name}</p>
            <p>Age: ${data.age}</p>
            <p>Weight: ${data.weight}</p>
        </div>
        </button>
     
        `;
      
        cowDisplay.innerHTML += newCowHTML;
        

      document.getElementById("cowForm").reset();
    })
    .catch(error => console.error('Error:', error));
}

*/

/*


let cowId = {
    cowId : document.getElementById('searchCow').value
  }



let promesa = await fetch('/search_cow',{

  method : 'POST',
  headers :{
    'Content-Type' : 'application/json'
  },
  body : JSON.stringify(cowId)
})

let cowInfo = await promesa.json

let searchDisplay = document.getElementById('showSearch').innerHTML

let newDisplay = ` 
          <div class="search-cow">
            <h2>${cowInfo.CowId}</h2>
            <p>ID: ${cowInfo[0].CowID}</p>
            <p>Name: ${cowInfo[0].CowName}</p>
            <p>Breed: ${cowInfo[0].Breed}</p>
            <p>Age: ${cowInfo[0].Age}</p>
            <p>Weight: ${cowInfo[0].Weight}</p>
            <p>Date Added: ${cowInfo[0].Date}</p> //checar esta parte
          </div> 



`;

searchDisplay = newDisplay

*/








  /*
  const inputData = {
    name: document.getElementById("modifyName").value,
    age: document.getElementById("modifyAge").value,
    breed: document.getElementById("modifyBreed").value,
    weight: document.getElementById("modifyWeight").value
  };

  if(inputData){
    try{

      let promesa = await fetch('/update_cow', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(inputData)
      })

      let status = await promesa.status


    
    }
    catch(exception){
    console.log(exception)
    }
  }
  else{
    //display introduce informacion
  }

  */





/*

let menu = document.querySelector('#menu-icon');
let navlist = document.querySelector('.navlist');

menu.onclick = () => {
    menu.classList.toggle('bx-x');
    navlist.classList.toggle('open');
};




const sr = ScrollReveal ({
    distance: '65px',
    duration: 2600,
    delay: 450,
    reset: true
});

sr.reveal('.model-text', {delay:200, origin: 'top'});
sr.reveal('.model-img', {delay:450, origin: 'top'});
sr.reveal('.icons', {delay:500, origin: 'left'});
sr.reveal('.scroll-down', {delay:500, origin: 'right'});

*/




    /*
    const newCowDisplay =  ` 
    
        <button class="cow-info-button">
        <div class="cow-info">
            <h2>Added Cow:</h2>
            <p>ID: ${cow_data[0].CowID}</p>
            <p>Name: ${cow_data[0].CowName}</p>
            <p>Breed: ${cow_data[0].Breed}</p>
            <p>Age: ${cow_data[0].Age}</p>
            <p>Weight: ${cow_data[0].Weight}</p>
        </div>
        </button>
     
    `;
    */

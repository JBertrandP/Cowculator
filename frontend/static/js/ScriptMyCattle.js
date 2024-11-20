

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



async function addCow() {
   
    const inputData = {
      name: document.getElementById("name").value,
      age: document.getElementById("age").value,
      breed: document.getElementById("breed").value,
      weight: document.getElementById("weight").value
    };

    console.log('Log desde js MyCattle')
    console.log(inputData)
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
    breed = inputData.breed

    updateContador(breed)
    
    cowDisplay.innerHTML += newCowDisplay
    
    }
    catch(error){
      console.log(error)
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
  
  console.log(cowData)

  let promesa = await fetch('/transfer_cow',{

    method : 'POST',
    headers : {
      'Content-Type': 'application/json'
    },
    body : JSON.stringify(cowData)

  })

  let response = promesa.status


  
}


document.addEventListener('DOMContentLoaded', function () {
  renderRecentlyAddedCows()
});

//intentar mover el index por uno 

async function renderRecentlyAddedCows(params) {
try{

let promesa = await fetch('/recently_added')

let cowData = await promesa.json()

console.log(cowData)


}catch(exception){
  console.log(exception)
}
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















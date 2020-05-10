const PARTICLE_COUNT= 300;
const state = {
    x: new Float32Array(PARTICLE_COUNT), // x location
    y: new Float32Array(PARTICLE_COUNT), // y location
    oldX: new Float32Array(PARTICLE_COUNT), // previous x location
    oldY: new Float32Array(PARTICLE_COUNT), // previous y location
    vx: new Float32Array(PARTICLE_COUNT), // horizontal velocity
    vy: new Float32Array(PARTICLE_COUNT), // vertical velocity
    p: new Float32Array(PARTICLE_COUNT), // pressure
    pNear: new Float32Array(PARTICLE_COUNT), // pressure near
    g: new Float32Array(PARTICLE_COUNT), // 'nearness' to neighbour
    }; 


var fps = 60;
//var capturer = new CCapture({format: 'png',framerate: fps});

const GRAVITY = [0,50];  
const GGG = 50;
const GRID_CELLS = 54;
const INTERACTION_RADIUS = 30;
const INTERACTION_RADIUS_SQ = INTERACTION_RADIUS*(INTERACTION_RADIUS);
const RADIUS_BLOB = 100;
const RADIUS_BLOB_SQ = RADIUS_BLOB*RADIUS_BLOB;
const STIFFNESS = 10;
const STIFFNESS_NEAR = 5;
const REST_DENSITY = 10;

const clamp = (value, min, max) => Math.min(Math.max(value, min), max);

class SpatialHashMap {
  constructor(width, height) {
    this.width = width;
    this.height = height;

    this.grid = new Array(width * height).fill(null).map(() => []);
  }

  clear() {
    this.grid.forEach(cell => {
      cell.splice(0);
    });
  }

  add(x, y, data) {
    //print(x);
    x = clamp(Math.round(x), 0, this.width - 1);
    y = clamp(Math.round(y), 0, this.height - 1);
    //print("---");
    //print(x);
    //print("A");
    //print(y);
    //print(width);

    const index = x + y * this.width;
    //print(index);
    this.grid[index].push(data);
  }

  query(x, y, radius) {
    if (radius) {
      return this.queryWithRadius(x, y, radius);
    }

    x = clamp(Math.round(x), 0, this.width - 1);
    y = clamp(Math.round(y), 0, this.height - 1);

    const index = x + y * this.width;
    return this.grid[index];
  }

  queryWithRadius(x, y, radius) {
    const left = Math.max(Math.round(x - radius), 0);
    const right = Math.min(Math.round(x + radius), this.width - 1);
    const bottom = Math.max(Math.round(y - radius), 0);
    const top = Math.min(Math.round(y + radius), this.height - 1);

    const result = [];

    for (let i = left; i <= right; i++) {
      for (let j = bottom; j <= top; j++) {
        const query = this.query(i, j);
        for (let k = 0; k < query.length; k++) {
          result.push(query[k]);
        }
      }
    }

    return result;
  }
}


var hashMap = new SpatialHashMap(GRID_CELLS,GRID_CELLS);
    
function setup(){
  //print(capturer);
  createCanvas(500,500);
  for (let i = 0; i < state.x.length; i++){
    let a = random(0,100);
    let b = random(0,100);
    state.x[i] = a;
    state.y[i] = b;
    state.oldX[i] = a;
    state.oldY[i] = b;
};
};

const applyGlobalForces2 = (i, dt) => {
    const particle = createVector(state.x[i], state.y[i]);
    const distance = particle.sub(createVector(mouseX-width/2, mouseY-height/2));
    const mouse_radius = 80;
    if (distance.mag() < mouse_radius){
    const dir = distance.normalize();
    const force = dir.mult(100);
    state.vx[i] += force.x* dt;
    state.vy[i] += force.y * dt;
    }
}; 

const applyGlobalForces = (i, dt) => {
    const particle = createVector(state.x[i], state.y[i]);
    const dir = particle.mult(-1).normalize();
    const force = dir.mult(100);
    state.vx[i] += force.x* dt;
    state.vy[i] += force.y * dt;
}; 


const dt = 0.04 ;

const getNeighboursWithGradients = i => {
  
    const gridX = (state.x[i] / width + 0.5) * GRID_CELLS;
    const gridY = (state.y[i] / height + 0.5) * GRID_CELLS;
    const radius = (INTERACTION_RADIUS / width) * GRID_CELLS;

    const results = hashMap.query(gridX, gridY, radius);
    const neighbours = [];

    for (let k = 0; k < results.length; k++) {

        const n = results[k];
        if (i === n) {continue;} // Skip itself

        const g = gradient(i, n);
        if (g === 0) {continue;}

        state.g[n] = g; // Store the gradient
        neighbours.push(n); // Push the neighbour to neighbours

    }

    return neighbours;

};

const gradient = (i, n) => {

    const particle = createVector(state.x[i], state.y[i]); // position of i
    const neighbour = createVector(state.x[n], state.y[n]); // position of n
  
    const lsq = particle.dist(neighbour)* particle.dist(neighbour);
    if (lsq > INTERACTION_RADIUS_SQ) {return 0;}

    const distance = Math.sqrt(lsq);
    return 1 - distance / INTERACTION_RADIUS;

};

const calculateVelocity = (i, dt) => {

    const pos = createVector(state.x[i], state.y[i]);
    const old = createVector(state.oldX[i], state.oldY[i]);

    const v = pos.sub(old).mult(1 / dt);

    state.vx[i] = v.x;
    state.vy[i] = v.y;

};

const contain2 = (i, dt) => {

    const particle = createVector(state.x[i], state.y[i]);
    const mousevec = createVector(mouseX-width/2, mouseY-height/2);
    const distance = particle.sub(mousevec);
    const mouse_radius = 50;
    if (distance.mag() < mouse_radius){
      const dir = distance.normalize();
      const newPos = mousevec.add(dir.mult(mouse_radius));
      state.x[i] = newPos.x;
      state.y[i] = newPos.y;
    }

};

const contain = (i, dt) => {

    const pos = createVector(state.x[i], state.y[i]);
  
    if (pos.mag()*pos.mag() > RADIUS_BLOB_SQ) {
    
        const unitPos = pos.normalize();
        const newPos = unitPos.mult(RADIUS_BLOB);

        state.x[i] = newPos.x;
        state.y[i] = newPos.y;

        const antiStick = unitPos.mult(INTERACTION_RADIUS * dt/100);

        state.oldX[i] += antiStick.x;
        state.oldY[i] += antiStick.y;

    }

};

const updateDensities = (i, neighbours) => {

    let density = 0;
    let nearDensity = 0;

    for (let k = 0; k < neighbours.length; k++) {
        const g = state.g[neighbours[k]]; // Get g for this neighbour
        density += g * g;
        nearDensity += g * g * g;
    }

    state.p[i] = STIFFNESS * (density - REST_DENSITY);
    state.pNear[i] = STIFFNESS_NEAR * nearDensity;

};

const relax = (i, neighbours, dt) => {
  
    const pos = createVector(state.x[i], state.y[i]);
  
    for (let k = 0; k < neighbours.length; k++) {
        const n = neighbours[k];
        const g = state.g[n];

        const nPos = createVector(state.x[n], state.y[n]);
        const magnitude = state.p[i] * g + state.pNear[i] * g * g;

        const direction = (nPos.sub(pos)).normalize();
        const force = direction.mult(magnitude);

        const d = force.mult(dt * dt);

        state.x[i] += d.x * - 0.5;
        state.y[i] += d.y * - 0.5;

        state.x[n] += d.x * 0.5;
        state.y[n] += d.y * 0.5;
    }

};

function draw() {
  background(200);
  
  for (let i = 0; i < PARTICLE_COUNT; i++) {

    // Update old position
    state.oldX[i] = state.x[i];
    state.oldY[i] = state.y[i];
    applyGlobalForces(i, dt);
    //applyGlobalForces2(i, dt);

    // Update positions
    state.x[i] += state.vx[i] * dt;
    state.y[i] += state.vy[i] * dt;

    // Update hashmap
    const gridX = (state.x[i] / width + 0.5) * GRID_CELLS;
    const gridY = (state.y[i] / height + 0.5) * GRID_CELLS;
    //print(i);
    //print("--");
    hashMap.add(gridX, gridY, i);

  }
  //print("kk");
  //print(state.x[0]);
  
  for (let i = 0; i < PARTICLE_COUNT; i++) {

    const neighbours = getNeighboursWithGradients(i);
    updateDensities(i, neighbours);
    
    // perform double density relaxation
    relax(i, neighbours, dt);

} 
  for (let i = 0; i < PARTICLE_COUNT; i++) {
  
      // Constrain the particles to a container
      contain(i, dt);
      contain2(i, dt);
  
      // Calculate new velocitiesr
      calculateVelocity(i, dt);
  
      // Update
      // state.mesh[i].position.set(state.x[i], state.y[i], 0);
  
  }
  
  for (let i = 0; i < PARTICLE_COUNT; i++){
    strokeWeight(5);
    point(state.x[i]+width/2, state.y[i]+height/2);
  }
  //print("kk");
  //print(state.x[0]);
  hashMap.clear();
  //saveFrames("output/gol_####.png");

}

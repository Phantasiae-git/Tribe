
function deg_to_radian(degree: number): number {
    let radian = degree * (Math.PI / 180);
    return radian;
}

// haversine formula returns distance between 2 coordinates such as 2 centers of where users want to live
// from this distance, we can calculate the score of the location using sigma in the gaussian function
function haversine_formula(coord1: [number, number], coord2: [number, number]) {
    const radius = 6371 // Earths radius in km

    const [lon1, lat1] = coord1;
    const [lon2, lat2] = coord2;

    let phi1 = deg_to_radian(lat1) // latitude of coord1 in radian
    let phi2 = deg_to_radian(lat2) // latitude of coord2 in radian
    let delta1 = deg_to_radian(lon1) //longitude of coord1 in radian
    let delta2 = deg_to_radian(lon2) //longitude of coord2 in radian

    let latD = phi2 - phi1;
    let lonD = delta2 - delta1;

    let dist = (2 * radius) * Math.asin(Math.sqrt( (Math.sin(latD / 2) ** 2) + Math.cos(phi1) * Math.cos(phi2) * (Math.sin(lonD / 2) ** 2) ));
    return dist; // in km
}

//tolerance_rad: radius(km) in which the location around where user wants to live is still acceptable
//tolerance_rad === sigma
function gaussian_kernel(distance: number, tolerance_rad: number = 5) {
    let score = Math.exp(-(distance ** 2) / (2 * tolerance_rad ** 2));
    return score;
}

// function will get centers of users from db and emit 
export default function location_score(coord1: [number, number], coord2: [number, number], sigma1: number = 5, sigma2: number = 5): number {
    let distanceKm = haversine_formula(coord1, coord2);
    let s1 = gaussian_kernel(distanceKm, sigma1);
    let s2 = gaussian_kernel(distanceKm, sigma2);
    return Math.min(s1, s2); // returning smallest because it should tke into account what both people want
}


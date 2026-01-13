export const skillImportance = 1.4
export const subscriptionImportance = 1.1
export const carImportance = 1.1
export const locationImportance = 1.35
export const mbtiImportance = 1.05
export const movingDateImportance = 1.2
export const placesofInterestImportance = 1.4


// undefined: not available
// 0.5: has but limited
// 1: fully available
export type Level = undefined | number;

export type LocationPreference = {
    center: [ lon: number, lat: number ]
    sigmaKm: number
    weight?: number // importance of location to live
}

export type Locations = LocationPreference[]

export type Animals = {
    hasAnimals: boolean
    animalTypes?: string[]
    animalNum?: number
}

export type Subscriptions = {
    netflix?: Level
    prime?: Level
    max?: Level
    plex?: Level
    spotify?: Level
    steam?: Level
    //etc
}

export type Skill = {
    level: Level
    willingness?: Level
}

export type Skills = {
    cooking?: Skill
    houseRepairs?: Skill
    bricollage?: Skill // ??
    cleaning?: Skill
    sewing?: Skill
    finances?: Skill
    //etc
}

export type Size = {
    min: number
    max: number
}

export type User = {
    username: string | null
    name: string | null
    id: number

    age: number //
    ageRange: [min: number, max: number] //
    gender: number // 0 for woman and 1 for man and 2 for other
    preferedRoomateGender: number | undefined // 0 for woman and 1 for man and 2 for other
    smokes: boolean
    smokingTolerant: boolean
    okWithAnimals: boolean
    animals: Animals
    groupSize: Size

    occupation: string
    student: boolean

    intendedMovingLocations: Locations
    intendedMovingDate: number | string // not sure yet should be from 0 to 3 of how soon or something similar
    dailyCommuteAreas: Locations // might use jaccard depending or gaussian kernel
    subscriptions: Subscriptions
    skills: Skills

    mbti: string
    placesofInterest: string[] // gym, library, etc 
    hobbies: string[]
    drivingLicense: boolean
    ownsCar: boolean
    
    currentLocation: [lon: number, lat: number]
    incomeLevel: number // from 0 to 5 or something similar
}

export const mbtiLine: string[] = [ "INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP", "ISFP", "ESFP", "ISTP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ" ];

export const mbtiGraph: number[][] = [ [0.75, 0.75, 0.75, 1, 0.75, 1, 0.75, 0.75, 0, 0, 0, 0, 0, 0, 0, 0],
                                        [0.75, 0.75, 1, 0.75, 1, 0.75, 0.75, 0.75, 0, 0, 0, 0, 0, 0, 0, 0],
                                        [0.75, 1, 0.75, 0.75, 1, 0.75, 0.75, 1, 0, 0, 0, 0, 0, 0, 0, 0],
                                        [1, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 1, 0, 0, 0, 0, 0, 0, 0],
                                        [0.75, 1, 0.75, 0.75, 0.75, 0.75, 0.75, 1, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25],
                                        [1, 0.75, 0.75, 0.75, 0.75, 0.75, 0.75, 1, 0.75, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5],
                                        [0.75, 0.75, 0.75, 0.75, 0.75, 1, 0.75, 0.75, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 1],
                                        [0.75, 0.75, 1, 0.75, 1, 0.75, 0.75, 0.75, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25],
                                        [0, 0, 0, 1, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.5, 1, 0.5, 1],
                                        [0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 1, 0.5, 1, 0.5],
                                        [0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 0.5, 1, 0.5, 1],
                                        [0, 0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, 1, 0.5, 1, 0.5],
                                        [0, 0, 0, 0, 0.25, 0.5, 0.25, 0.25, 0.5, 1, 0.5, 1, 0.75, 0.75, 0.75, 0.75],
                                        [0, 0, 0, 0, 0.25, 0.5, 0.25, 0.25, 1, 0.5, 1, 0.5, 0.75, 0.75, 0.75, 0.75],
                                        [0, 0, 0, 0, 0.25, 0.5, 0.25, 0.25, 0.5, 1, 0.5, 1, 0.75, 0.75, 0.75, 0.75],
                                        [0, 0, 0, 0, 0.25, 0.5, 1, 0.25, 1, 0.5, 1, 0.5, 0.75, 0.75, 0.75, 0.75]
                                        ];
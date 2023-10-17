extends Node3D

class_name FilmManipulator

#stores whether or not the current holder has film
var hasFilm := false
#the film object
var film : Photo
#signal for when given film
signal given
#signal for when film is taken
signal taken

# LittleSweetHome
Little Sweet Home in a application designed to control home sensors (camera, temperature, motion, etc.), based on Molecule Component Framework.

## Installing

```smalltalk
Metacello new
   baseline: 'LittleSweetHome';
   repository: 'github://OpenSmock/LittleSweetHome/src';
   load.
```

## Demo

To start the demo (open a Transcript to display application messages) :

```smalltalk
launcher := LSHLauncher start.
```

Demo capacities : 

```smalltalk
launcher demoAddCameras.
launcher demoAddTemperatureSensor.
launcher demoMotionSensor.
launcher demoRecording.
launcher demoRecordingControlledCamera.
launcher demoRecordingFixedCamera.
launcher demoTemperatureSensor. 
```

## Credits

* **Camille Delloye** - *Initial work*
* **Eric Le Pors** - *Initial work* - [ELePors](https://github.com/ELePors)
* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)

## License

This project is licensed under the MIT License.

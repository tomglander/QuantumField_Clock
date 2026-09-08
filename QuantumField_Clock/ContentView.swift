import SwiftUI

// =============================================================
// MoodClock — Quantum Field Clock
// Fresh visual development file.
//
// VISUAL REFERENCE:
// The supplied quantum-field image is the design foundation.
// This version deliberately moves away from the mechanical gear
// language and treats the clock as a living field of energy.
//
// CORE IDEA:
// Time is represented as a disturbance moving through a quantum field.
//
// CLOCK LOGIC:
// • Hour    = large orbital structure
// • Minute  = horizontal energy-wave phase
// • Second  = bright particle moving around the field
//
// This is a fresh visual treatment. The underlying time source uses
// the real current system time and updates continuously.
// =============================================================

import SwiftUI

struct ContentView: View {

    var body: some View {

        TimelineView(.animation(minimumInterval: 1.0 / 60.0)) { timeline in

            let time = timeline.date.timeIntervalSinceReferenceDate

            ZStack {

                Color.black
                    .ignoresSafeArea()

                QuantumFieldClock(time: time)
            }
        }
    }
}

// =============================================================
// MARK: - Quantum Field Clock
// =============================================================

struct QuantumFieldClock: View {

    let time: TimeInterval

    var body: some View {

        let date = Date(timeIntervalSinceReferenceDate: time)
        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let nanosecond = calendar.component(.nanosecond, from: date)

        let fractionalSecond =
            Double(nanosecond) / 1_000_000_000.0

        // Continuous clock positions.

        let hourPosition =
            Double(hour % 12)
            + Double(minute) / 60.0
            + (Double(second) + fractionalSecond) / 3600.0

        let minutePosition =
            Double(minute)
            + (Double(second) + fractionalSecond) / 60.0

        let secondPosition =
            Double(second) + fractionalSecond

        let secondPhase =
            secondPosition / 60.0

        let minutePhase =
            minutePosition / 60.0

        let hourPhase =
            hourPosition / 12.0

        ZStack {

            // =================================================
            // FIELD AURA
            // =================================================

            QuantumFieldAura(
                time: time,
                hourPhase: hourPhase,
                minutePhase: minutePhase
            )

            // =================================================
            // MAIN FIELD
            // =================================================

            QuantumFieldParticles(
                time: time,
                hourPhase: hourPhase,
                minutePhase: minutePhase
            )

            // =================================================
            // HOUR QUANTUM STATES
            //
            // Twelve sparse field nodes establish the clock's
            // hidden 12-hour structure without creating a dial.
            // The current hour becomes an energized probability
            // state rather than a conventional hour hand.
            // =================================================

            QuantumHourStates(
                time: time,
                hourPosition: hourPosition
            )

            // =================================================
            // FIELD RESONANCE
            //
            // A quiet standing-wave structure now connects the
            // outer hour states to the central quantum core.
            // The current minute determines where the strongest
            // resonance appears.
            // =================================================

            FieldResonance(
                time: time,
                minutePhase: minutePhase,
                hourPhase: hourPhase
            )

            // =================================================
            // CENTRAL QUANTUM CORE
            // =================================================

            QuantumCore(
                time: time,
                minutePhase: minutePhase,
                secondPosition: secondPosition
            )

            // =================================================
            // HORIZONTAL ENERGY WAVE
            // =================================================

            QuantumWave(
                time: time,
                minutePhase: minutePhase,
                secondPosition: secondPosition
            )

            // =================================================
            // MINUTE WAVE FRONT
            //
            // A localized packet of energy travels through the
            // horizontal waveform. Its position is the minute.
            // It is deliberately softer than a hand.
            // =================================================

            MinuteWaveFront(
                minutePosition: minutePosition,
                secondPosition: secondPosition
            )

            // =================================================
            // SECOND PARTICLE
            // =================================================

            SecondParticle(
                secondPhase: secondPhase
            )

            // =================================================
            // SUBTLE GLASS / FIELD EDGE
            // =================================================

            Circle()
                .stroke(
                    Color.white.opacity(0.075),
                    lineWidth: 1
                )
                .frame(width: 350, height: 350)

            Circle()
                .stroke(
                    Color.cyan.opacity(0.055),
                    lineWidth: 1
                )
                .frame(width: 366, height: 366)

        }
        .frame(width: 390, height: 390)
    }
}

// =============================================================
// MARK: - Field Aura
// =============================================================

struct QuantumFieldAura: View {

    let time: TimeInterval
    let hourPhase: Double
    let minutePhase: Double

    var body: some View {

        ZStack {

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.045),
                            Color.cyan.opacity(0.045),
                            Color.blue.opacity(0.025),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 5,
                        endRadius: 205
                    )
                )
                .frame(width: 410, height: 410)
                .blur(radius: 18)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.purple.opacity(0.035),
                            Color.blue.opacity(0.025),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 30,
                        endRadius: 250
                    )
                )
                .frame(width: 500, height: 500)
                .blur(radius: 28)

            // Slow breathing of the entire field.

            Circle()
                .stroke(
                    Color.cyan.opacity(
                        0.055 + 0.025 * sin(time * 0.55)
                    ),
                    lineWidth: 1
                )
                .frame(width: 330, height: 330)

            Circle()
                .stroke(
                    Color.orange.opacity(
                        0.035 + 0.018 * sin(time * 0.42 + 2.0)
                    ),
                    lineWidth: 1
                )
                .frame(width: 300, height: 300)
        }
    }
}

// =============================================================
// MARK: - Quantum Field Particles
// =============================================================

struct QuantumFieldParticles: View {

    let time: TimeInterval
    let hourPhase: Double
    let minutePhase: Double

    var body: some View {

        Canvas { context, size in

            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )

            let scale = min(size.width, size.height) / 390.0

            // -------------------------------------------------
            // ORBITAL FIELD
            // -------------------------------------------------

            let orbitRadii: [CGFloat] = [
                62, 82, 105, 128, 150
            ]

            for (index, radiusValue) in orbitRadii.enumerated() {

                let radius = radiusValue * scale

                var orbit = Path()

                orbit.addEllipse(
                    in: CGRect(
                        x: center.x - radius,
                        y: center.y - radius * 0.72,
                        width: radius * 2,
                        height: radius * 1.44
                    )
                )

                let opacity =
                    0.055
                    + Double(index) * 0.012
                    + 0.015 * sin(
                        time * (0.25 + Double(index) * 0.04)
                        + hourPhase * Double.pi * 2
                    )

                context.stroke(
                    orbit,
                    with: .color(
                        index.isMultiple(of: 2)
                        ? Color.cyan.opacity(opacity)
                        : Color.white.opacity(opacity)
                    ),
                    lineWidth: index == 2 ? 1.2 : 0.65
                )
            }

            // -------------------------------------------------
            // CROSSING ORBITAL PLANES
            // -------------------------------------------------
            //
            // The reference imagery has several orbital planes
            // crossing through the energy field. These are not
            // decorative circles: each plane is slightly rotated,
            // tilted, and breathing, creating the impression that
            // the particles occupy a real three-dimensional field.
            // -------------------------------------------------

            for index in 0..<7 {

                let seed = Double(index)

                let rotation =
                    seed * 25.0
                    + time * (1.4 + seed * 0.18)

                let widthFactor =
                    0.88 + 0.08 * sin(time * 0.35 + seed)

                let heightFactor =
                    0.24
                    + 0.13 * abs(
                        sin(time * 0.28 + seed * 1.7)
                    )

                let orbitWidth = 304.0 * widthFactor * Double(scale)
                let orbitHeight = 168.0 * heightFactor * Double(scale)

                context.drawLayer { orbitalContext in
                    orbitalContext.translateBy(
                        x: center.x,
                        y: center.y
                    )
                    orbitalContext.rotate(
                        by: .degrees(rotation)
                    )

                    var orbit = Path()
                    orbit.addEllipse(
                        in: CGRect(
                            x: -orbitWidth / 2.0,
                            y: -orbitHeight / 2.0,
                            width: orbitWidth,
                            height: orbitHeight
                        )
                    )

                    let shimmer =
                        0.025
                        + 0.018 * (
                            0.5
                            + 0.5 * sin(
                                time * 0.8
                                + seed * 1.9
                            )
                        )

                    orbitalContext.stroke(
                        orbit,
                        with: .color(
                            index.isMultiple(of: 3)
                            ? Color.white.opacity(shimmer)
                            : Color.cyan.opacity(shimmer)
                        ),
                        lineWidth: index == 3 ? 1.0 : 0.55
                    )
                }
            }

            // -------------------------------------------------
            // FILAMENT NETWORK
            // -------------------------------------------------

            for index in 0..<18 {

                let angle =
                    Double(index) / 18.0
                    * Double.pi * 2
                    + hourPhase * Double.pi * 2

                let radius =
                    (92.0 + 48.0 * sin(
                        Double(index) * 2.71
                        + minutePhase * Double.pi * 2
                    )) * scale

                let x =
                    center.x
                    + CGFloat(cos(angle)) * radius

                let y =
                    center.y
                    + CGFloat(sin(angle)) * radius * 0.72

                var filament = Path()

                filament.move(to: center)

                filament.addLine(
                    to: CGPoint(x: x, y: y)
                )

                context.stroke(
                    filament,
                    with: .color(
                        Color.white.opacity(0.035)
                    ),
                    lineWidth: 0.55
                )
            }

            // -------------------------------------------------
            // ORBITAL PARTICLE SWARMS
            // -------------------------------------------------
            // The small particles now have jobs to do. Each belongs
            // to an orbital lane, travels along it, and leaves a
            // short energetic wake behind it.
            // -------------------------------------------------

            for index in 0..<26 {

                let seed = Double(index)
                let plane = seed.truncatingRemainder(dividingBy: 7.0)

                let rotationDegrees =
                    plane * 25.0
                    + time * (1.4 + plane * 0.18)

                let rotation =
                    rotationDegrees * Double.pi / 180.0

                let widthFactor =
                    0.88 + 0.08 * sin(time * 0.35 + plane)

                let heightFactor =
                    0.24 + 0.13 * abs(
                        sin(time * 0.28 + plane * 1.7)
                    )

                let orbitWidth =
                    304.0 * widthFactor * Double(scale)

                let orbitHeight =
                    168.0 * heightFactor * Double(scale)

                // Each particle has its own orbital velocity and phase.
                let speed =
                    0.20
                    + seed.truncatingRemainder(dividingBy: 6.0) * 0.035

                let basePhase =
                    seed * 1.91
                    + time * speed
                    + minutePhase * Double.pi * 2
                    + plane * 0.43

                // -------------------------------------------------
                // MOVING RESONANCE GATE
                // -------------------------------------------------
                // The field now has a place where energy briefly
                // gathers. Particles passing through this moving
                // gate are pulled slightly toward the nucleus, then
                // released back into their orbital lanes.
                // This gives the swarm a collective behavior rather
                // than making every particle simply repeat a loop.

                let gateAngle =
                    minutePhase * Double.pi * 2
                    + time * 0.70

                let angularDifference = abs(
                    atan2(
                        sin(basePhase - gateAngle),
                        cos(basePhase - gateAngle)
                    )
                )

                let gateInfluence = exp(
                    -pow(angularDifference / 0.25, 2.0)
                )

                let radialPull =
                    1.0 - 0.16 * gateInfluence

                let phaseOffset =
                    0.12 * gateInfluence

                let phase = basePhase + phaseOffset

                let localX =
                    cos(phase)
                    * orbitWidth
                    * 0.5
                    * radialPull

                let localY =
                    sin(phase)
                    * orbitHeight
                    * 0.5
                    * radialPull

                // Rotate the particle into its moving orbital plane.
                let rotatedX =
                    localX * cos(rotation)
                    - localY * sin(rotation)

                let rotatedY =
                    localX * sin(rotation)
                    + localY * cos(rotation)

                let x = center.x + CGFloat(rotatedX)
                let y = center.y + CGFloat(rotatedY)

                // Particles become more energetic near the nucleus.
                let centerDistance = sqrt(
                    rotatedX * rotatedX
                    + rotatedY * rotatedY
                )

                let centralEnergy = max(
                    0.0,
                    1.0 - centerDistance / 170.0
                )

                // Particles inside the resonance gate become briefly
                // brighter and leave a more visible trace. The effect
                // follows the moving gate rather than the clock hand.
                let gateEnergy =
                    gateInfluence * (0.35 + centralEnergy * 0.65)

                let pulse =
                    0.65 + 0.35 * sin(time * 1.7 + seed * 2.2)

                let particleSize =
                    1.5
                    + CGFloat(centralEnergy) * 2.2
                    + CGFloat(max(0.0, pulse))

                // -------------------------------------------------
                // ORBITAL WAKE
                // -------------------------------------------------
                // A particle leaves a short chain of fading energy.

                for trailIndex in 1..<7 {

                    let trailPhase =
                        phase - Double(trailIndex) * 0.075

                    let trailLocalX =
                        cos(trailPhase) * orbitWidth * 0.5

                    let trailLocalY =
                        sin(trailPhase) * orbitHeight * 0.5

                    let trailX =
                        trailLocalX * cos(rotation)
                        - trailLocalY * sin(rotation)

                    let trailY =
                        trailLocalX * sin(rotation)
                        + trailLocalY * cos(rotation)

                    let trailOpacity = max(
                        0.0,
                        0.22
                        - Double(trailIndex) * 0.030
                        + gateEnergy * 0.16
                    )

                    let trailSize = max(
                        0.7,
                        particleSize * (
                            0.72 - CGFloat(trailIndex) * 0.08
                        )
                    )

                    let trailRect = CGRect(
                        x: center.x + CGFloat(trailX) - trailSize / 2,
                        y: center.y + CGFloat(trailY) - trailSize / 2,
                        width: trailSize,
                        height: trailSize
                    )

                    context.fill(
                        Path(ellipseIn: trailRect),
                        with: .color(
                            index % 9 == 0
                            ? Color.orange.opacity(trailOpacity)
                            : Color.cyan.opacity(trailOpacity)
                        )
                    )
                }

                // Main particle.
                let particleRect = CGRect(
                    x: x - particleSize / 2,
                    y: y - particleSize / 2,
                    width: particleSize,
                    height: particleSize
                )

                let warmParticle =
                    index % 9 == 0 || index % 13 == 0

                context.fill(
                    Path(ellipseIn: particleRect),
                    with: .color(
                        warmParticle
                        ? Color.orange.opacity(
                            min(1.0, 0.72 + centralEnergy * 0.18 + gateEnergy * 0.28)
                        )
                        : Color.cyan.opacity(
                            min(1.0, 0.64 + centralEnergy * 0.22 + gateEnergy * 0.30)
                        )
                    )
                )

                // A few particles flare at the orbital crossings.
                if centralEnergy > 0.72 && index % 4 == 0 {

                    let nodeSize = particleSize * 2.8

                    context.fill(
                        Path(
                            ellipseIn: CGRect(
                                x: x - nodeSize / 2,
                                y: y - nodeSize / 2,
                                width: nodeSize,
                                height: nodeSize
                            )
                        ),
                        with: .color(
                            Color.white.opacity(0.18 * centralEnergy)
                        )
                    )
                }
            }

            // -------------------------------------------------
            // ORBITAL WAYPOINTS
            // -------------------------------------------------
            // A few larger nodes give the smaller particles places
            // to appear to converge, cross, and continue from.

            for index in 0..<8 {

                let seed = Double(index)

                let phase =
                    seed * Double.pi * 0.78
                    + time * (0.18 + seed * 0.012)
                    + hourPhase * Double.pi * 2

                let radiusX =
                    (78.0 + seed * 9.0) * Double(scale)

                let radiusY = radiusX * 0.48

                let x =
                    center.x + CGFloat(cos(phase) * radiusX)

                let y =
                    center.y + CGFloat(sin(phase) * radiusY)

                let size =
                    CGFloat(2.8 + 0.8 * sin(time * 1.2 + seed))

                context.fill(
                    Path(
                        ellipseIn: CGRect(
                            x: x - size / 2,
                            y: y - size / 2,
                            width: size,
                            height: size
                        )
                    ),
                    with: .color(
                        index.isMultiple(of: 3)
                        ? Color.orange.opacity(0.70)
                        : Color(red: 1.0, green: 0.68, blue: 0.20).opacity(0.72)
                    )
                )
            }

        }
        .frame(width: 360, height: 360)
    }
}

// =============================================================
// MARK: - Hour Quantum States
// =============================================================
//
// Twelve nodes form a loose probability shell rather than a
// traditional clock face. The current hour is expressed by the
// strongest energized state. The next state begins to wake as
// the hour approaches, creating a continuous transition.
// =============================================================

struct QuantumHourStates: View {

    let time: TimeInterval
    let hourPosition: Double

    var body: some View {

        ZStack {

            // A very faint orbital shell establishes the twelve
            // positions without drawing a conventional clock face.

            Ellipse()
                .stroke(
                    Color.white.opacity(0.045),
                    lineWidth: 0.7
                )
                .frame(width: 304, height: 222)

            ForEach(0..<12, id: \.self) { index in

                let position = Double(index)
                let distance = hourDistance(
                    from: position,
                    to: hourPosition
                )

                // The active hour carries the strongest energy.
                // The next hour begins waking as time approaches it.

                let influence = max(
                    0.0,
                    1.0 - distance / 2.4
                )

                let currentInfluence = max(
                    0.0,
                    1.0 - distance / 0.72
                )

                let angle =
                    position / 12.0
                    * Double.pi * 2
                    - Double.pi / 2

                let radius: CGFloat = 152

                let x = cos(angle) * radius
                let y = sin(angle) * radius * 0.73

                ZStack {

                    // Large, soft probability cloud. This is the
                    // primary hour signal rather than a clock tick.

                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(
                                        0.12 + 0.30 * influence
                                    ),
                                    Color.cyan.opacity(
                                        0.12 + 0.42 * influence
                                    ),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 1,
                                endRadius: 24
                            )
                        )
                        .frame(
                            width: 52 + CGFloat(influence * 30),
                            height: 52 + CGFloat(influence * 30)
                        )
                        .blur(radius: 5 + CGFloat(influence * 4))

                    // A tighter energetic node gives the eye a place
                    // to land when identifying the current hour.

                    Circle()
                        .fill(
                            Color(red: 1.0, green: 0.66, blue: 0.12).opacity(
                                0.38 + 0.62 * influence
                            )
                        )
                        .frame(
                            width: 2.6 + CGFloat(
                                5.6 * influence
                                + 4.0 * currentInfluence
                            ),
                            height: 2.6 + CGFloat(
                                5.6 * influence
                                + 4.0 * currentInfluence
                            )
                        )
                        .shadow(
                            color: Color(red: 1.0, green: 0.56, blue: 0.08).opacity(
                                0.42 + 0.72 * influence
                            ),
                            radius: 4 + CGFloat(influence * 8)
                        )
                        .shadow(
                            color: Color(red: 1.0, green: 0.78, blue: 0.28).opacity(
                                0.34 + 0.58 * currentInfluence
                            ),
                            radius: 2 + CGFloat(currentInfluence * 6)
                        )
                }
                .offset(x: x, y: y)
            }

            // A barely visible rotating energy arc connects the
            // active hour's neighborhood to the field. It provides
            // orientation without becoming an hour hand.

            Circle()
                .trim(
                    from: 0.0,
                    to: 0.082
                )
                .stroke(
                    Color.cyan.opacity(0.10),
                    style: StrokeStyle(
                        lineWidth: 1.0,
                        lineCap: .round
                    )
                )
                .frame(width: 304, height: 222)
                .rotationEffect(
                    .degrees(
                        hourPosition * 30.0 - 90.0
                    )
                )
                .blur(radius: 0.4)
        }
        .allowsHitTesting(false)
    }

    private func hourDistance(
        from state: Double,
        to position: Double
    ) -> Double {

        let difference = abs(state - position)

        return min(
            difference,
            12.0 - difference
        )
    }
}

// =============================================================
// MARK: - Minute Wave Front
// =============================================================
//
// The minute is no longer only represented by the overall wave.
// A concentrated wave packet moves through it. At the beginning
// of each minute it crosses the center and then travels outward.
//
// This creates a second layer of time information without adding
// a conventional hand.
// =============================================================

struct MinuteWaveFront: View {

    let minutePosition: Double
    let secondPosition: Double

    var body: some View {

        let progress =
            minutePosition / 60.0

        let x =
            CGFloat(progress * 360.0 - 180.0)

        ZStack {

            // =================================================
            // MINUTE = A LIVING PART OF THE WAVE
            //
            // The minute marker is no longer a dot sitting on
            // top of the waveform. It is a short, intensified
            // section of the waveform itself.
            // =================================================

            Canvas { context, size in

                let centerY = size.height / 2.0
                let centerX = size.width / 2.0

                // Soft local atmosphere around the energized
                // portion of the wave.

                let glowRect = CGRect(
                    x: centerX - 36,
                    y: centerY - 36,
                    width: 72,
                    height: 72
                )

                context.fill(
                    Path(ellipseIn: glowRect),
                    with: .radialGradient(
                        Gradient(colors: [
                            Color(red: 1.0, green: 0.68, blue: 0.20).opacity(0.30),
                            Color.orange.opacity(0.10),
                            Color.clear
                        ]),
                        center: CGPoint(x: centerX, y: centerY),
                        startRadius: 0,
                        endRadius: 36
                    )
                )

                // Several short waveform strands overlap at the
                // minute position. Their shared center becomes the
                // visual identity of the minute without being a dot.

                for strand in 0..<7 {

                    let path = Path { path in

                        let verticalScale =
                            7.0 + Double(strand) * 1.25

                        let phase =
                            Double(strand) * 0.48

                        path.move(
                            to: CGPoint(
                                x: 4,
                                y: centerY
                            )
                        )

                        for sample in 0...90 {

                            let localX =
                                Double(sample) / 90.0 * 82.0
                                - 41.0

                            let envelope =
                                exp(-pow(localX / 32.0, 2.0))

                            let wave =
                                sin(localX * 0.34 + phase)

                            let y =
                                centerY
                                + wave * verticalScale * envelope

                            path.addLine(
                                to: CGPoint(
                                    x: centerX + localX,
                                    y: y
                                )
                            )
                        }
                    }

                    context.stroke(
                        path,
                        with: .color(
                            strand == 3
                            ? Color.white.opacity(0.88)
                            : Color.cyan.opacity(
                                0.24 + Double(6 - strand) * 0.045
                            )
                        ),
                        style: StrokeStyle(
                            lineWidth: strand == 3 ? 1.6 : 1.0,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                }

                // =================================================
                // MINUTE WAKE
                //
                // For a brief moment after the minute changes, the
                // wave remembers where the minute knot just came from.
                // This is intentionally a soft gaseous disturbance,
                // not a trail or a second marker.
                // =================================================

                let wakeWindow =
                    max(0.0, min(1.0, (2.25 - secondPosition) / 2.25))

                let wakeFade =
                    wakeWindow * wakeWindow

                let wakeRect = CGRect(
                    x: centerX - 82,
                    y: centerY - 20,
                    width: 78,
                    height: 40
                )

                context.fill(
                    Path(ellipseIn: wakeRect),
                    with: .radialGradient(
                        Gradient(colors: [
                            Color.cyan.opacity(0.34 * wakeFade),
                            Color.blue.opacity(0.15 * wakeFade),
                            Color.clear
                        ]),
                        center: CGPoint(x: centerX - 38, y: centerY),
                        startRadius: 0,
                        endRadius: 50
                    )
                )

                // A few nearly invisible filaments give the wake a
                // gaseous, fluid quality as it dissipates.

                for wakeIndex in 0..<5 {

                    let wakePath = Path { path in

                        let verticalScale =
                            2.5 + Double(wakeIndex) * 0.9

                        path.move(
                            to: CGPoint(
                                x: centerX - 80,
                                y: centerY
                            )
                        )

                        for sample in 0...48 {

                            let localX =
                                Double(sample) / 60.0 * 78.0 - 78.0

                            let fade =
                                exp(-pow((localX + 40.0) / 34.0, 2.0))

                            let wave =
                                sin(localX * 0.28 + Double(wakeIndex) * 0.75)

                            let y =
                                centerY + wave * verticalScale * fade

                            path.addLine(
                                to: CGPoint(
                                    x: centerX + localX,
                                    y: y
                                )
                            )
                        }
                    }

                    context.stroke(
                        wakePath,
                        with: .color(
                            Color.cyan.opacity(0.22 * wakeFade)
                        ),
                        style: StrokeStyle(
                            lineWidth: 0.8,
                            lineCap: .round,
                            lineJoin: .round
                        )
                    )
                }

                // A concentrated luminous knot marks the exact
                // crossing point. It is created as light inside the
                // waveform, not as a separate geometric dot.

                let coreRect = CGRect(
                    x: centerX - 7,
                    y: centerY - 7,
                    width: 14,
                    height: 14
                )

                context.fill(
                    Path(ellipseIn: coreRect),
                    with: .radialGradient(
                        Gradient(colors: [
                            Color.white.opacity(0.98),
                            Color(red: 1.0, green: 0.68, blue: 0.20).opacity(0.84),
                            Color.clear
                        ]),
                        center: CGPoint(x: centerX, y: centerY),
                        startRadius: 0,
                        endRadius: 7
                    )
                )
            }
            .frame(width: 170, height: 100)
            .blur(radius: 0.35)

            // A restrained horizontal haze ties the energized
            // section directly back into the existing waveform.

            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            Color.clear,
                            Color.cyan.opacity(0.14),
                            Color.white.opacity(0.28),
                            Color.cyan.opacity(0.14),
                            Color.clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 120, height: 6)
                .blur(radius: 3)
        }
        .offset(x: x)
        .allowsHitTesting(false)
    }
}

// =============================================================
// MARK: - Field Resonance
// =============================================================

struct FieldResonance: View {

    let time: TimeInterval
    let minutePhase: Double
    let hourPhase: Double

    var body: some View {

        Canvas { context, size in

            let center = CGPoint(
                x: size.width / 2,
                y: size.height / 2
            )

            // Twelve faint radial channels form the hidden
            // hour structure. They are deliberately incomplete:
            // the field should suggest a clock, not display a dial.

            for index in 0..<12 {

                let hourPosition = Double(index) / 12.0
                let baseAngle =
                    hourPosition * Double.pi * 2
                    - Double.pi / 2

                // Each persistent time-position node is golden; the current hour becomes the strongest resonance.
                let angularDistance =
                    abs(
                        atan2(
                            sin(
                                baseAngle
                                - hourPhase * Double.pi * 2
                            ),
                            cos(
                                baseAngle
                                - hourPhase * Double.pi * 2
                            )
                        )
                    )

                let hourStrength =
                    exp(
                        -pow(
                            angularDistance / 0.34,
                            2.0
                        )
                    )

                let innerRadius: CGFloat = 76
                let outerRadius: CGFloat =
                    151 + CGFloat(hourStrength) * 12

                let start = CGPoint(
                    x: center.x
                        + cos(baseAngle) * innerRadius,
                    y: center.y
                        + sin(baseAngle) * innerRadius * 0.72
                )

                let end = CGPoint(
                    x: center.x
                        + cos(baseAngle) * outerRadius,
                    y: center.y
                        + sin(baseAngle) * outerRadius * 0.72
                )

                var path = Path()
                path.move(to: start)
                path.addLine(to: end)

                context.stroke(
                    path,
                    with: .color(
                        Color.cyan.opacity(
                            0.025
                            + 0.12 * hourStrength
                        )
                    ),
                    lineWidth:
                        0.65
                        + CGFloat(hourStrength) * 1.0
                )

                // Small quantum node at each hour state.

                let nodeSize =
                    2.2
                    + CGFloat(hourStrength) * 6.0

                let node = CGRect(
                    x: end.x - nodeSize / 2,
                    y: end.y - nodeSize / 2,
                    width: nodeSize,
                    height: nodeSize
                )

                // Golden resonance node: this is the persistent
                // orbital time-position marker, distinct from the
                // white seconds comet and the white-blue nucleus.
                // Its warm tone matches the minute knot and the
                // golden envelope around the nucleus.

                let resonanceGlowSize =
                    nodeSize * (3.6 + 2.0 * hourStrength)

                let resonanceGlow = CGRect(
                    x: end.x - resonanceGlowSize / 2,
                    y: end.y - resonanceGlowSize / 2,
                    width: resonanceGlowSize,
                    height: resonanceGlowSize
                )

                context.fill(
                    Path(ellipseIn: resonanceGlow),
                    with: .radialGradient(
                        Gradient(colors: [
                            Color(red: 1.0, green: 0.66, blue: 0.12).opacity(
                                0.34 + 0.34 * hourStrength
                            ),
                            Color(red: 1.0, green: 0.42, blue: 0.04).opacity(
                                0.10 + 0.16 * hourStrength
                            ),
                            Color.clear
                        ]),
                        center: CGPoint(x: end.x, y: end.y),
                        startRadius: 0,
                        endRadius: resonanceGlowSize / 2
                    )
                )

                context.fill(
                    Path(ellipseIn: node),
                    with: .color(
                        Color(red: 1.0, green: 0.66, blue: 0.12).opacity(
                            0.28
                            + 0.68 * hourStrength
                        )
                    )
                )
            }

            // -------------------------------------------------
            // MINUTE RESONANCE RINGS
            //
            // The minute isn't a hand. It changes the field's
            // wavelength, producing a moving interference band.
            // -------------------------------------------------

            for ring in 0..<7 {

                let radius =
                    CGFloat(48 + ring * 17)

                let phase =
                    minutePhase * Double.pi * 2
                    + time * 0.35
                    + Double(ring) * 0.82

                let modulation =
                    0.5
                    + 0.5 * sin(phase)

                var ellipse = Path()

                ellipse.addEllipse(
                    in: CGRect(
                        x: center.x - radius,
                        y: center.y - radius * 0.72,
                        width: radius * 2,
                        height: radius * 1.44
                    )
                )

                context.stroke(
                    ellipse,
                    with: .color(
                        ring.isMultiple(of: 2)
                        ? Color.cyan.opacity(
                            0.018
                            + 0.055 * modulation
                        )
                        : Color.purple.opacity(
                            0.014
                            + 0.040 * modulation
                        )
                    ),
                    lineWidth: 0.65
                )
            }
        }
        .frame(width: 350, height: 350)
        .allowsHitTesting(false)
    }
}

// =============================================================
// MARK: - Quantum Core
// =============================================================

struct QuantumCore: View {

    let time: TimeInterval
    let minutePhase: Double
    let secondPosition: Double

    var body: some View {

        let pulse =
            1.0
            + 0.055 * sin(time * 2.4)
            + 0.025 * sin(
                time * 5.1
                + minutePhase * Double.pi * 2
            )

        ZStack {

            // Outer core energy.

            ForEach(0..<5, id: \.self) { index in

                let size =
                    CGFloat(54 + index * 19)

                Circle()
                    .stroke(
                        index.isMultiple(of: 2)
                        ? Color.cyan.opacity(
                            0.13 - Double(index) * 0.017
                        )
                        : Color.purple.opacity(
                            0.10 - Double(index) * 0.014
                        ),
                        lineWidth: index == 0 ? 1.2 : 0.7
                    )
                    .frame(
                        width: size,
                        height: size * 0.72
                    )
                    .rotationEffect(
                        .degrees(
                            time * (
                                3.0
                                + Double(index) * 1.7
                            )
                        )
                    )
                    .scaleEffect(pulse)
            }

            // -------------------------------------------------
            // GOLDEN RADIANT ENVELOPE
            //
            // The hottest point remains white-blue. A warm gold
            // layer now surrounds it, giving the nucleus a more
            // dimensional, star-like temperature gradient.
            // The same minute timing used by the wave drives a
            // temporary increase in the golden intensity.
            // -------------------------------------------------

            let minuteWindow =
                max(0.0, min(1.0, (2.15 - secondPosition) / 2.15))

            let minuteBreath =
                1.0 - minuteWindow * minuteWindow

            let goldenIntensity =
                0.72 + minuteBreath * 0.72

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.98),
                            Color.cyan.opacity(0.92),
                            Color.yellow.opacity(
                                0.42 * goldenIntensity
                            ),
                            Color.orange.opacity(
                                0.26 * goldenIntensity
                            ),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 3,
                        endRadius: 39
                    )
                )
                .frame(width: 76, height: 76)
                .scaleEffect(
                    pulse * (1.0 + minuteBreath * 0.10)
                )
                .blur(radius: 3.5)

            // A softer golden halo sits outside the nucleus and
            // becomes noticeably hotter at the top of each minute.

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.yellow.opacity(
                                0.30 * goldenIntensity
                            ),
                            Color.orange.opacity(
                                0.16 * goldenIntensity
                            ),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 8,
                        endRadius: 58
                    )
                )
                .frame(width: 116, height: 116)
                .scaleEffect(
                    pulse * (1.0 + minuteBreath * 0.16)
                )
                .blur(radius: 6)

            // Hot central nucleus remains white-blue.

            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white,
                            Color.cyan.opacity(0.98),
                            Color.blue.opacity(0.62),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 24
                    )
                )
                .frame(width: 46, height: 46)
                .scaleEffect(pulse)
                .blur(radius: 2.5)

            Circle()
                .fill(Color.white)
                .frame(width: 9, height: 9)
                .shadow(
                    color: Color.white.opacity(0.95),
                    radius: 4
                )
                .shadow(
                    color: Color.cyan.opacity(0.95),
                    radius: 14
                )
                .shadow(
                    color: Color.orange.opacity(
                        0.65 * goldenIntensity
                    ),
                    radius: 22
                )
        }
    }
}


// =============================================================
// MARK: - Quantum Wave
// =============================================================
//
// The horizontal wave is the visual signature of the Quantum Field.
// This version deliberately moves it much closer to the reference
// image: many coherent wave strands, a white-hot central crossing,
// broad blue/cyan energy on the left, and a warm amber/orange field
// on the right.
//
// The wave remains a time-bearing structure rather than decoration.
// Its phase is still driven by the minute, while the fine structure
// continuously moves through the field at 60 fps.
// =============================================================

struct QuantumWave: View {

    let time: TimeInterval
    let minutePhase: Double
    let secondPosition: Double

    var body: some View {

        Canvas { context, size in

            let width = size.width
            let centerY = size.height / 2
            let centerX = width / 2

            // ---------------------------------------------------------
            // MINUTE VERTICAL EXPANSION
            // ---------------------------------------------------------
            // At the exact minute boundary, the existing waveform itself
            // briefly breathes outward in the vertical direction. There
            // is no added ring, ray, or shock front. The wave simply gets
            // taller through the center, then settles back into its normal
            // shape over the same ~2.15 second timing as the previous pulse.

            let minuteWindow: Double =
                max(
                    0.0,
                    min(1.0, (2.15 - secondPosition) / 2.15)
                )

            let minuteBreath: Double =
                1.0 - minuteWindow * minuteWindow

            // A smooth envelope keeps the expansion concentrated around
            // the central energy mass, with softer shoulders so it feels
            // gaseous rather than mechanical.
            func minuteVerticalExpansion(_ x: Double) -> Double {
                let dx = x - centerX
                let centralCloud =
                    exp(-pow(dx / 92.0, 2.0))
                let broadCloud =
                    exp(-pow(dx / 172.0, 4.0))

                // A very soft traveling ripple inside the expanding gas.
                // It modulates height only; it never creates a separate
                // object or shockwave.
                let ripple =
                    0.5 + 0.5 * sin(
                        dx * 0.052
                        - time * 1.15
                        + minutePhase * Double.pi * 2.0
                    )

                return 1.0
                    + minuteBreath
                    * (
                        centralCloud * 1.55
                        + broadCloud * (0.38 + ripple * 0.20)
                    )
            }

            // ---------------------------------------------------------
            // MASTER WAVE MATH
            // ---------------------------------------------------------
            // A broad Gaussian envelope keeps the strongest energy near
            // the center while allowing the wave to taper naturally at
            // both edges.

            func envelope(_ x: Double) -> Double {
                let normalized = (x / width) - 0.5
                return exp(-pow(normalized / 0.46, 2.0))
            }

            // ---------------------------------------------------------
            // CENTRAL MASS / LEFT TRAIL
            // ---------------------------------------------------------
            // A subtle concentration of energy builds as the wave
            // approaches the center. A softer trailing tail extends
            // toward the left edge, suggesting a disturbance that has
            // passed through the field rather than a static waveform.

            func massProfile(_ x: Double) -> Double {
                let centerMass =
                    exp(-pow((x - centerX) / 72.0, 2.0))

                let leftTrail =
                    x < centerX
                    ? exp(-pow((x - centerX) / 170.0, 2.0))
                    : 0.0

                return 0.58 * centerMass + 0.30 * leftTrail
            }

            // ---------------------------------------------------------
            // DEEP ENERGY GLOW
            // ---------------------------------------------------------
            // These very wide, faint strokes establish the luminous
            // volume before the sharper filaments are drawn.

            for glow in 0..<3 {

                var path = Path()

                let amplitude = 25.0 + Double(glow) * 10.0
                let frequency = 0.058 + Double(glow) * 0.006
                let phase =
                    time * (0.72 + Double(glow) * 0.08)
                    + minutePhase * Double.pi * 2
                    + Double(glow) * 0.45

                for x in stride(from: 0.0, through: width, by: 1.5) {

                    let env = envelope(x)
                    let carrier = sin(x * frequency + phase)
                    let harmonic = 0.28 * sin(
                        x * frequency * 2.07 - phase * 0.61
                    )

                    let verticalExpansion = minuteVerticalExpansion(x)
                    let y =
                        centerY
                        + CGFloat(
                            (carrier + harmonic)
                            * amplitude
                            * env
                            * verticalExpansion
                        )

                    let point = CGPoint(x: x, y: y)

                    if x == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }

                context.stroke(
                    path,
                    with: .color(
                        Color.cyan.opacity(
                            0.035 - Double(glow) * 0.007
                        )
                    ),
                    lineWidth:
                        (11.0 - CGFloat(glow) * 2.5)
                        + CGFloat(minuteBreath * (7.0 - Double(glow) * 1.2))
                )
            }

            // ---------------------------------------------------------
            // FILLED ENERGY LOBES
            // ---------------------------------------------------------
            // The reference image does not read as a handful of lines.
            // Each visible wave has luminous *body*.  We build that body
            // mathematically from nested contours.  The contours pack
            // closer together and broaden around the center, then relax
            // again after crossing it.  This creates the substantial,
            // almost translucent-mesh appearance of the reference image.

            for family in 0..<5 {

                let f = Double(family)
                let baseFrequency: Double = 0.050 + f * 0.0125
                let baseAmplitude: Double = 19.0 - f * 1.80
                let basePhase: Double =
                    minutePhase * Double.pi * 2
                    + time * (0.58 + f * 0.075)
                    + f * 0.63

                // Twenty-one nested contours give each wave a real body
                // instead of merely increasing the stroke width.
                for contour in 0..<21 {

                    let c = Double(contour) - 10.0
                    let contourPosition: Double = c / 10.0
                    var path = Path()

                    for x in stride(from: 0.0, through: width, by: 1.25) {

                        let env: Double = envelope(x)
                        let dx: Double = x - centerX

                        // Broad central shoulder: the wave gains mass on
                        // approach, stays substantial through the crossing,
                        // and gently releases that mass on departure.
                        let centerBody: Double =
                            exp(-pow(dx / 118.0, 2.0))

                        let shoulderBody: Double =
                            exp(-pow(dx / 178.0, 4.0))

                        let bodyGain: Double =
                            1.0 + centerBody * 0.36 + shoulderBody * 0.21

                        // The contour spacing itself expands near center.
                        // This is what makes each individual wave look
                        // physically fatter rather than simply brighter.
                        let contourSpread: Double =
                            (1.15 + centerBody * 3.8 + shoulderBody * 1.25)
                            * contourPosition

                        let carrierPhase: Double =
                            x * baseFrequency + basePhase

                        let carrier: Double = sin(carrierPhase)

                        let harmonicPhase: Double =
                            x * baseFrequency * 2.03
                            - basePhase * 0.57
                            + f * 0.41

                        let harmonic: Double =
                            sin(harmonicPhase) * 0.16

                        let waveValue: Double = carrier + harmonic
                        let displacement: Double =
                            waveValue * baseAmplitude * env * bodyGain

                        let verticalExpansion = minuteVerticalExpansion(x)
                        let yOffset: Double =
                            (displacement + contourSpread * env)
                            * verticalExpansion

                        let y: CGFloat = centerY + CGFloat(yOffset)
                        let point = CGPoint(x: x, y: y)

                        if x == 0 {
                            path.move(to: point)
                        } else {
                            path.addLine(to: point)
                        }
                    }

                    let contourStrength: Double =
                        1.0 - min(1.0, abs(contourPosition))

                    let opacity: Double =
                        0.022 + contourStrength * 0.050

                    context.stroke(
                        path,
                        with: .linearGradient(
                            Gradient(colors: [
                                Color.blue.opacity(opacity * 0.80),
                                Color.cyan.opacity(opacity * 1.45),
                                Color.white.opacity(opacity * 1.85),
                                Color.white.opacity(opacity * 1.95),
                                Color.orange.opacity(opacity * 1.45),
                                Color.red.opacity(opacity * 0.78)
                            ]),
                            startPoint: CGPoint(x: 0, y: centerY),
                            endPoint: CGPoint(x: width, y: centerY)
                        ),
                        lineWidth: contour == 10 ? 0.72 : 0.34
                    )
                }
            }

            // ---------------------------------------------------------
            // PRIMARY MULTI-STRAND WAVE
            // ---------------------------------------------------------
            // Each strand has a slightly different frequency, amplitude
            // and phase. Together they produce dense interference.

            for strand in 0..<11 {

                var path = Path()

                let s = Double(strand)
                let centered = s - 5.0

                let amplitude =
                    9.0
                    + abs(centered) * 2.25
                    + (strand.isMultiple(of: 3) ? 2.0 : 0.0)

                let frequency = 0.072 + s * 0.0047

                let phase =
                    minutePhase * Double.pi * 2
                    + time * (0.86 + s * 0.055)
                    + s * 0.31

                for x in stride(from: 0.0, through: width, by: 1.25) {

                    let env = envelope(x)
                    let dx = Double(x) - centerX

                    // Central compression makes the waveform appear to
                    // pass through the quantum core.
                    let compression =
                        0.74
                        + 0.26 * exp(-pow(dx / 74.0, 2.0))

                    // Energy becomes visibly denser as the disturbance
                    // reaches the core, then falls away into a fine trail.
                    let mass = 1.0 + massProfile(x)

                    let carrier = sin(x * frequency + phase)
                    let secondHarmonic = 0.22 * sin(
                        x * frequency * 2.31
                        - phase * 0.72
                        + s
                    )
                    let thirdHarmonic = 0.08 * sin(
                        x * frequency * 4.17
                        + phase * 1.31
                    )

                    let verticalExpansion = minuteVerticalExpansion(x)
                    let y =
                        centerY
                        + CGFloat(
                            (carrier + secondHarmonic + thirdHarmonic)
                            * amplitude
                            * env
                            * compression
                            * mass
                            * verticalExpansion
                        )

                    let point = CGPoint(x: x, y: y)

                    if x == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }

                // Continuous blue-to-white-to-orange energy transition.
                let gradient = Gradient(colors: [
                    Color.blue.opacity(0.20),
                    Color.cyan.opacity(0.42),
                    Color.white.opacity(0.76),
                    Color.white.opacity(0.82),
                    Color.orange.opacity(0.46),
                    Color.red.opacity(0.22)
                ])

                context.stroke(
                    path,
                    with: .linearGradient(
                        gradient,
                        startPoint: CGPoint(x: 0, y: centerY),
                        endPoint: CGPoint(x: width, y: centerY)
                    ),
                    lineWidth:
                        strand == 5
                        ? 1.72
                        : (strand.isMultiple(of: 2) ? 0.94 : 0.66)
                )
            }

            // ---------------------------------------------------------
            // HIGH-FREQUENCY RIPPLE
            // ---------------------------------------------------------
            // Fine wavelength creates filament texture without changing
            // the readable overall waveform.

            for ripple in 0..<5 {

                var path = Path()
                let r = Double(ripple)

                let amplitude = 4.0 + r * 1.4
                let frequency = 0.19 + r * 0.012
                let phase =
                    time * (1.35 + r * 0.09)
                    - minutePhase * Double.pi * 2
                    + r * 1.07

                for x in stride(from: 0.0, through: width, by: 1.0) {

                    let env = envelope(x)

                    // A finer ripple rides inside the mass pocket. It is
                    // strongest near the center and dissolves into the
                    // leftward wake. This is deliberately visible, but
                    // not strong enough to read as a second hand.

                    let carrier = sin(x * frequency + phase)
                    let modulator =
                        0.55
                        + 0.45 * sin(
                            x * 0.038
                            - time * 0.45
                            + r
                        )

                    let verticalExpansion = minuteVerticalExpansion(x)
                    let y =
                        centerY
                        + CGFloat(
                            carrier
                            * amplitude
                            * env
                            * modulator
                            * verticalExpansion
                        )

                    let point = CGPoint(x: x, y: y)

                    if x == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }

                context.stroke(
                    path,
                    with: .linearGradient(
                        Gradient(colors: [
                            Color.cyan.opacity(0.20),
                            Color.white.opacity(0.36),
                            Color.orange.opacity(0.20)
                        ]),
                        startPoint: CGPoint(x: 0, y: centerY),
                        endPoint: CGPoint(x: width, y: centerY)
                    ),
                    lineWidth: 0.42
                )
            }

            // ---------------------------------------------------------
            // TRAVELING RIPPLE / ENERGY DISTURBANCE
            // ---------------------------------------------------------
            // This is the new visual cue: a compact, layered ripple
            // gathers toward the center and leaves a diminishing wake
            // toward the left. Its meaning can evolve later. For now
            // it simply makes the field feel like something is happening.

            for rippleBand in 0..<13 {

                let rb = Double(rippleBand) - 6.0
                var path = Path()

                for x in stride(from: 0.0, through: width, by: 1.0) {

                    let env = envelope(x)
                    let mass = massProfile(x)

                    let packet = exp(
                        -pow((x - centerX) / (82.0 + abs(rb) * 4.0), 2.0)
                    )

                    let wake = x < centerX
                        ? exp(-pow((x - centerX) / (155.0 + abs(rb) * 6.0), 2.0))
                        : 0.0

                    // Break the ripple calculation into small, explicitly
                    // typed sub-expressions. This keeps Swift's type checker
                    // from having to solve the entire expression at once.
                    let rippleFrequency: Double =
                        0.145 + abs(rb) * 0.006

                    let ripplePhase: Double =
                        x * rippleFrequency
                        + time * 1.7
                        + rb * 0.54

                    let rippleValue: Double =
                        sin(ripplePhase)

                    let rippleAmplitude: Double =
                        1.5 + packet * 5.5 + wake * 2.0

                    let massMultiplier: Double =
                        0.55 + mass * 0.9

                    let verticalDisplacement: Double =
                        rippleValue
                        * rippleAmplitude
                        * massMultiplier
                        * env

                    let centerOffset: Double =
                        rb * 1.45 * packet

                    let verticalExpansion = minuteVerticalExpansion(x)
                    let yOffset: CGFloat =
                        CGFloat(
                            (verticalDisplacement + centerOffset)
                            * verticalExpansion
                        )

                    let y: CGFloat =
                        centerY + yOffset

                    let point = CGPoint(x: x, y: y)

                    if x == 0 {
                        path.move(to: point)
                    } else {
                        path.addLine(to: point)
                    }
                }

                context.stroke(
                    path,
                    with: .linearGradient(
                        Gradient(colors: [
                            Color.cyan.opacity(0.045),
                            Color.cyan.opacity(0.12),
                            Color.white.opacity(0.34),
                            Color.orange.opacity(0.12)
                        ]),
                        startPoint: CGPoint(x: 0, y: centerY),
                        endPoint: CGPoint(x: width, y: centerY)
                    ),
                    lineWidth: rippleBand == 6 ? 0.72 : 0.34
                )
            }

            // ---------------------------------------------------------
            // CENTRAL INTERFERENCE BAND
            // ---------------------------------------------------------
            // Nearly horizontal micro-lines create the white-hot crossing
            // where the wave meets the quantum core.

            for band in 0..<9 {

                let b = Double(band) - 4.0
                var path = Path()

                path.move(
                    to: CGPoint(
                        x: 84,
                        y: centerY + CGFloat(b * 0.75)
                    )
                )

                path.addCurve(
                    to: CGPoint(
                        x: width - 84,
                        y: centerY - CGFloat(b * 0.75)
                    ),
                    control1: CGPoint(
                        x: centerX - 70,
                        y: centerY + CGFloat(b * 1.9)
                    ),
                    control2: CGPoint(
                        x: centerX + 70,
                        y: centerY - CGFloat(b * 1.9)
                    )
                )

                context.stroke(
                    path,
                    with: .color(
                        Color.white.opacity(
                            0.035 + (4.0 - abs(b)) * 0.012
                        )
                    ),
                    lineWidth: 0.45
                )
            }

            // ---------------------------------------------------------
            // QUANTUM WAVE PARTICLES
            // ---------------------------------------------------------
            // Tiny points ride the waveform. Their distribution is
            // deterministic, so the field feels designed rather than
            // randomly regenerated every frame.

            for index in 0..<48 {

                let i = Double(index)
                let x =
                    (i / 47.0) * width
                    + sin(time * 0.22 + i * 1.71) * 2.4

                let env = envelope(x)

                let frequency =
                    0.085
                    + (i.truncatingRemainder(dividingBy: 5.0) * 0.0047)

                let phase =
                    minutePhase * Double.pi * 2
                    + time * 0.92
                    + i * 0.31

                // Break this into typed pieces so Swift does not have to
                // infer the entire particle-position expression at once.
                let verticalExpansion: Double =
                    minuteVerticalExpansion(x)

                let particleAngle: Double =
                    x * frequency + phase

                let particleWave: Double =
                    sin(particleAngle)

                let particleBand: Double =
                    13.0
                    + (i.truncatingRemainder(dividingBy: 4.0) * 3.0)

                let particleDisplacement: Double =
                    particleWave
                    * particleBand
                    * env
                    * verticalExpansion

                let y: CGFloat =
                    centerY + CGFloat(particleDisplacement)

                let size =
                    0.9
                    + (i.truncatingRemainder(dividingBy: 5.0) == 0 ? 1.2 : 0.0)

                let particle = Path(
                    ellipseIn: CGRect(
                        x: x - size / 2,
                        y: y - size / 2,
                        width: size,
                        height: size
                    )
                )

                context.fill(
                    particle,
                    with: .color(
                        x < centerX
                        ? Color.cyan.opacity(0.58 * env)
                        : Color.orange.opacity(0.50 * env)
                    )
                )
            }

            // ---------------------------------------------------------
            // CENTERLINE
            // ---------------------------------------------------------
            // A nearly invisible energy axis anchors the waveform.

            var axis = Path()
            axis.move(to: CGPoint(x: 0, y: centerY))
            axis.addLine(to: CGPoint(x: width, y: centerY))

            context.stroke(
                axis,
                with: .linearGradient(
                    Gradient(colors: [
                        Color.blue.opacity(0.12),
                        Color.cyan.opacity(0.24),
                        Color.white.opacity(0.58),
                        Color.orange.opacity(0.24),
                        Color.red.opacity(0.12)
                    ]),
                    startPoint: CGPoint(x: 0, y: centerY),
                    endPoint: CGPoint(x: width, y: centerY)
                ),
                lineWidth: 0.65
            )
        }
        .frame(width: 390, height: 350)
        .allowsHitTesting(false)
    }
}

// =============================================================
// MARK: - Second Particle
// =============================================================

struct SecondParticle: View {

    let secondPhase: Double

    var body: some View {

        let angle =
            secondPhase * Double.pi * 2
            - Double.pi / 2

        let radius: CGFloat = 100

        let x =
            cos(angle) * radius

        let y =
            sin(angle) * radius * 0.72

        ZStack {

            // ---------------------------------------------------------
            // SECOND-PARTICLE TRAIL
            // A short, luminous wake follows the particle around its
            // orbit.  The wake is strongest immediately behind it and
            // fades smoothly with distance.
            // ---------------------------------------------------------

            // Broad atmospheric glow behind the particle.
            ForEach(1..<34, id: \.self) { index in

                let distance = Double(index)
                let trailAngle =
                    angle - distance * 0.028

                let fade =
                    pow(max(0.0, 1.0 - distance / 34.0), 1.45)

                let trailRadius =
                    radius - CGFloat(distance) * 0.35

                Circle()
                    .fill(
                        Color.cyan.opacity(0.19 * fade)
                    )
                    .frame(
                        width: 13.0 + CGFloat(7.0 * fade),
                        height: 13.0 + CGFloat(7.0 * fade)
                    )
                    .blur(radius: 5.5 + CGFloat(3.5 * fade))
                    .offset(
                        x: cos(trailAngle) * trailRadius,
                        y: sin(trailAngle)
                            * trailRadius
                            * 0.72
                    )
            }

            // Brighter inner filament of the wake.
            ForEach(1..<22, id: \.self) { index in

                let distance = Double(index)
                let trailAngle =
                    angle - distance * 0.032

                let fade =
                    pow(max(0.0, 1.0 - distance / 22.0), 1.65)

                let trailRadius =
                    radius - CGFloat(distance) * 0.22

                Circle()
                    .fill(
                        Color.white.opacity(0.30 * fade)
                    )
                    .frame(
                        width: 4.5 + CGFloat(2.8 * fade),
                        height: 4.5 + CGFloat(2.8 * fade)
                    )
                    .blur(radius: 1.5)
                    .offset(
                        x: cos(trailAngle) * trailRadius,
                        y: sin(trailAngle)
                            * trailRadius
                            * 0.72
                    )
            }

            // The seconds particle itself.
            Circle()
                .fill(Color.white)
                .frame(width: 9, height: 9)
                .shadow(
                    color: Color.white,
                    radius: 6.5
                )
                .shadow(
                    color: Color.cyan,
                    radius: 17
                )
                .shadow(
                    color: Color.blue.opacity(0.90),
                    radius: 30
                )
        }
        .offset(x: x, y: y)
    }
}

// =============================================================
// MARK: - Legacy Time Readout (not used)
// =============================================================

struct TimeReadout: View {

    let hour: Int
    let minute: Int

    var body: some View {

        let displayHour =
            hour % 12 == 0 ? 12 : hour % 12

        HStack(spacing: 5) {

            Text("\(displayHour)")
                .font(
                    .system(
                        size: 16,
                        weight: .medium,
                        design: .rounded
                    )
                )

            Text(":")
                .opacity(0.35)

            Text(
                String(format: "%02d", minute)
            )
            .font(
                .system(
                    size: 16,
                    weight: .medium,
                    design: .rounded
                )
            )
        }
        .foregroundStyle(
            Color.white.opacity(0.48)
        )
        .shadow(
            color: Color.cyan.opacity(0.5),
            radius: 7
        )
        .offset(y: 176)
    }
}

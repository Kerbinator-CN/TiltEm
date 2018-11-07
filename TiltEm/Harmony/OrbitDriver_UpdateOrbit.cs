﻿using Harmony;

// ReSharper disable All

namespace TiltEm.Harmony
{
    /// <summary>
    /// This harmony patch is intended to update the orbits and apply them the planet tilt
    /// </summary>
    [HarmonyPatch(typeof(OrbitDriver))]
    [HarmonyPatch("UpdateOrbit")]
    internal class OrbitDriver_UpdateOrbit
    {
        [HarmonyPrefix]
        private static void PrefixUpdateOrbit(OrbitDriver __instance, ref bool __state)
        {
            //We NEVER tilt the orbit frames for vessels that are in TRACK_Phys mode
            //Otherwise the orbits of them get messy after the frame is tilted
            if (__instance.updateMode == OrbitDriver.UpdateMode.TRACK_Phys)
                return;

            if (__instance.referenceBody && __instance.referenceBody.inverseRotation && TiltEm.TryGetTilt(__instance.referenceBody.bodyName, out var tilt))
            {
                __state = true;
                TiltEmUtil.ApplyTiltToFrame(ref __instance.orbit.OrbitFrame, -1 * tilt);
            }
        }

        [HarmonyPostfix]
        private static void PostfixUpdateOrbit(OrbitDriver __instance, ref bool __state)
        {
            if (__state)
            {
                Planetarium.CelestialFrame.OrbitalFrame(__instance.orbit.LAN, __instance.orbit.inclination, __instance.orbit.argumentOfPeriapsis, ref __instance.orbit.OrbitFrame);
            }
        }
    }
}
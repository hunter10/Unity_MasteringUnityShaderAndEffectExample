﻿Shader "PACKT/Planet_falloff" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Thickness("Thickness", Range(-1, 1)) = 0.5
        _AtmosColor("Atmosphere Color", Color) = (1,1,1,1)
    }
    
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};


		fixed4 _Color;
		      
		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG

        Cull Front
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha vertex:vert
        struct Input{
            float2 uv_MainTex;
        };

        float _Thickness;

        void vert(inout appdata_full v){
            v.vertex.xyz += v.normal * _Thickness;
        }

        fixed4 _AtmosColor;
        void surf(Input IN, inout SurfaceOutputStandard o){
            o.Albedo = _AtmosColor.rgb;
            o.Alpha = _AtmosColor.a;
        }
        ENDCG
	}
	FallBack "Diffuse"
}

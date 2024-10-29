unit MaterialColor.Scheme.Fidelity;

interface

uses
  MaterialColor.CAM.HCT,
  MaterialColor.DynamicColor.DynamicScheme;

type
  /// <summary>
  /// A scheme that places the source color in Scheme.primaryContainer.
  /// </summary>
  /// <remarks>
  /// <para>Primary Container is the source color, adjusted for color relativity. It maintains constant appearance in light mode and dark mode. This adds ~5 tone in light mode, and subtracts ~5 tone in dark mode.</para>
  /// <para>Tertiary Container is the complement to the source color, using TemperatureCache. It also maintains constant appearance.</para>
  /// </remarks>
  TSchemeFidelity = class(TDynamicSchemeBuilder)
  public
    /// <summary>
    /// Constructs a dynamic color scheme.
    /// </summary>
    /// <param name="set_source_color_hct">The source color in HCT color space.</param>
    /// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
    /// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
    /// <returns>A dynamically constructed color scheme.</returns>
    class function Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double = 0.0): TDynamicScheme; override;
  end;

implementation

uses
  System.Math,
  MaterialColor.Dislike,
  MaterialColor.DynamicColor.Variant,
  MaterialColor.Palettes.Tones,
  MaterialColor.TemperatureCache;

{ TSchemeFidelity }

/// <summary>
/// Constructs a dynamic color scheme.
/// </summary>
/// <param name="set_source_color_hct">The source color in HCT color space.</param>
/// <param name="set_is_dark">Indicates if the scheme is for dark mode.</param>
/// <param name="set_contrast_level">The level of contrast adjustment. Default is 0.0.</param>
/// <returns>A dynamically constructed color scheme.</returns>
class function TSchemeFidelity.Construct(set_source_color_hct: THCT; set_is_dark: Boolean; set_contrast_level: Double): TDynamicScheme;

/// <summary>
/// Determines the key color for the tertiary palette.
/// </summary>
/// <returns>The HCT color for the tertiary palette.</returns>
function TertiaryPaletteKeyColor: THCT;
begin
  var cache: ITemperatureCache := TTemperatureCache.Create(set_source_color_hct);
  Result := cache.GetComplement;
end;

begin
  Result := TDynamicScheme.Create(
    (* source_color_argb: *) set_source_color_hct.ToInt,
    (* variant: *) TDynamicColorVariant.kFidelity,
    (* contrast_level: *) set_contrast_level,
    (* is_dark: *) set_is_dark,
    (* primary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue,
                         set_source_color_hct.Chroma),
    (* secondary_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue,
                         Max(set_source_color_hct.Chroma - 32.0, set_source_color_hct.Chroma * 0.5)),
    (* tertiary_palette: *)
    TTonalPalette.Create(FixIfDisliked(TertiaryPaletteKeyColor)),
    (* neutral_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue,
                         set_source_color_hct.Chroma / 8.0),
    (* neutral_variant_palette: *)
    TTonalPalette.Create(set_source_color_hct.Hue,
                         set_source_color_hct.Chroma / 8.0 + 4.0)
  );
end;

end.


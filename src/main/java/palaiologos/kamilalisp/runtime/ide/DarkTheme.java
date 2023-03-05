/*
 * Copyright 2020 FormDev Software GmbH
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package palaiologos.kamilalisp.runtime.ide;

import com.formdev.flatlaf.IntelliJTheme;
import com.formdev.flatlaf.util.LoggingFacade;

import java.io.IOException;
import java.util.Objects;

public class DarkTheme
	extends IntelliJTheme.ThemeLaf
{
	public static final String NAME = "Atom One Dark (Material)";

	public static boolean setup() {
		return setup( new DarkTheme() );
	}

	static IntelliJTheme loadTheme() {
		try {
			return new IntelliJTheme(Objects.requireNonNull(DarkTheme.class.getResourceAsStream("/theme.json")));
		} catch( IOException ex ) {
			throw new RuntimeException(ex);
		}
	}

	public static void installLafInfo() {
		installLafInfo( NAME, DarkTheme.class );
	}

	public DarkTheme() {
		super( loadTheme() );
	}

	@Override
	public String getName() {
		return NAME;
	}
}

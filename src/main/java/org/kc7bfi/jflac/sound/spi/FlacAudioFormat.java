/**
 * 
 */
package org.kc7bfi.jflac.sound.spi;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioSystem;

import org.kc7bfi.jflac.metadata.StreamInfo;

/**
 * An AudioFormat instance wrapping a FLAC StreamInfo object. With Java 5.0
 * style properties support.
 * 
 * @author Florian Bomers
 */
public class FlacAudioFormat extends AudioFormat {

	/**
	 * Property key for minimum frame size. The value is of type Integer and
	 * gives the minimum size of encoded frames in bytes.
	 */
	public static final String KEY_FRAMESIZE_MIN = "framesize_min";
	/**
	 * Property key for maximum frame size. The value is of type Integer and
	 * gives the maximum size of encoded frames in bytes.
	 */
	public static final String KEY_FRAMESIZE_MAX = "framesize_max";
	/**
	 * Property key for minimum block size. The value is of type Integer and
	 * gives the minimum size of decoded frames in bytes.
	 */
	public static final String KEY_BLOCKSIZE_MIN = "blocksize_min";
	/**
	 * Property key for maximum block size. The value is of type Integer and
	 * gives the maximum size of decoded frames in bytes.
	 */
	public static final String KEY_BLOCKSIZE_MAX = "blocksize_max";

	private HashMap props;

	public FlacAudioFormat(StreamInfo streamInfo) {
		super(FlacEncoding.FLAC, streamInfo.getSampleRate(),
				streamInfo.getBitsPerSample(), streamInfo.getChannels(),
				/* streamInfo.maxFrameSize */AudioSystem.NOT_SPECIFIED,
				AudioSystem.NOT_SPECIFIED, false);
		props = new HashMap();
		props.put(KEY_FRAMESIZE_MIN, new Integer(streamInfo.getMinFrameSize()));
		props.put(KEY_FRAMESIZE_MAX, new Integer(streamInfo.getMaxFrameSize()));
		props.put(KEY_BLOCKSIZE_MIN, new Integer(streamInfo.getMinBlockSize()));
		props.put(KEY_BLOCKSIZE_MAX, new Integer(streamInfo.getMaxBlockSize()));
	}

	/**
	 * Java 5.0 compatible method to get the full map of properties. The
	 * properties use the KEY_ keys defined in this class.
	 */
	public Map properties() {
		Map ret;
		if (props == null) {
			ret = new HashMap(0);
		} else {
			ret = (HashMap) (props.clone());
		}
		return Collections.unmodifiableMap(ret);
	}

	/**
	 * Java 5.0 compatible method to get a property. As key use the KEY_ constants defined in this class.
	 */
	public Object getProperty(String key) {
		if (props == null) {
			return null;
		}
		return props.get(key);
	}
}
